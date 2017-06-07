#!/bin/bash

command_exists() {
    type "$1" &> /dev/null ;
}

install_puppet() {
    if command_exists dpkg; then
        source /etc/os-release
        release_file="puppetlabs-release-pc1-${UBUNTU_CODENAME:?}.deb"
        wget "https://apt.puppetlabs.com/${release_file:?}"
        sudo dpkg -i ${release_file:?}
        rm ${release_file:?}
        sudo apt-get update
        sudo apt-get install puppet-agent -y
    elif command_exists yum; then
        source /etc/os-release
        release_file="puppetlabs-release-pc1-el-${VERSION_ID:?}.noarch.rpm"
        sudo rpm -Uvh "https://yum.puppetlabs.com/${release_file:?}"
        sudo yum install puppet-agent -y
    fi
}

if ! command_exists /opt/puppetlabs/puppet/bin/puppet; then
    install_puppet
fi

puppet="/opt/puppetlabs/puppet/bin/puppet"
r10k="/opt/puppetlabs/puppet/bin/r10k"

sudo ${puppet:?} module install puppet/r10k --force
sudo ${puppet:?} apply -e "\
class { 'r10k':\
  sources => {\
    'default' => {\
      'remote'  => 'https://github.com/demophoon/puppet-environment.git',\
      'basedir' => '/etc/puppetlabs/code/environments',\
    },\
  },\
}"

sudo ${r10k:?} deploy environment -pv
sudo ${puppet:?} apply --modulepath /etc/puppetlabs/code/environments/production/modules/ /etc/puppetlabs/code/environments/production/site.pp
