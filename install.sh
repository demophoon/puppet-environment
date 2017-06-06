#!/bin/bash

command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists dpkg; then
    source /etc/os-release

    release_file="puppetlabs-release-pc1-${UBUNTU_CODENAME:?}.deb"
    wget "https://apt.puppetlabs.com/${release_file:?}"
    sudo dpkg -i ${release_file:?}
    sudo apt-get update
    sudo apt-get install puppet-agent
elif command_exists yum; then
    echo "Not yet supported. Sorry :("
    exit 1
fi

puppet="/opt/puppetlabs/puppet/bin/puppet"
r10k="/opt/puppetlabs/puppet/bin/r10k"

${puppet:?} module install puppet/r10k
${puppet:?} apply -e "\
class { 'r10k':\
  sources => {\
    'default' => {\
      'remote'  => 'https://github.com/demophoon/puppet-environment.git',\
      'basedir' => '/etc/puppetlabs/code/environments',\
    },\
  },\
}"

${r10k:?} deploy environment -pv
${puppet:?} apply --modulepath /etc/puppetlabs/code/environments/production/site.pp
