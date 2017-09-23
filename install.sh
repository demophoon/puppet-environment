#!/bin/bash

command_exists() {
    type "$1" &> /dev/null ;
}

install_puppet() {
    # Currently only supports ubuntu
    if command_exists dpkg; then
        source /etc/os-release
        release_file="puppet5-release-${UBUNTU_CODENAME:?}.deb"
        wget "https://apt.puppetlabs.com/${release_file:?}"
        dpkg -i ${release_file:?}
        rm ${release_file:?}
        apt-get update
        apt-get install puppet-agent -y
    elif command_exists yum; then
        source /etc/os-release
        release_file="puppet5-release-el-${VERSION_ID:?}.noarch.rpm"
        rpm -Uvh "https://yum.puppetlabs.com/${release_file:?}"
        yum install puppet-agent -y
    else
      echo "Unsupported platform :("
      exit 1
    fi
}

confirm() {
  read -p '> ' response
  echo
  if [[ ${response} =~ [yY] ]]; then
    return 0
  fi
  return 1
}

if [ ${UID} -ne 0 ]; then
  echo "This script must run as root to work properly."
  exit 1
fi

if ! command_exists /opt/puppetlabs/puppet/bin/puppet; then
    install_puppet
fi

echo "Would you like to setup access to your hiera data repo? [y/N]"
echo "Warning: Only answer yes to this if you are Demophoon or have access to the private hiera data repo!"

if confirm; then
  if [ ! -f /root/.ssh/id_rsa.pub ]; then
    echo "We couldn't find a ssh key in '/root/.ssh/'."
    echo "Would you like us to generate one? [y/N]"
    echo "Warning: Answering no may cause the install script to fail!"
    if confirm; then
      ssh-keygen -b 4096 -t rsa -f '/root/.ssh/id_rsa'
      echo
    fi
  fi
  echo "Add the following public key to the hiera data repo's deploy keys."
  echo
  cat /root/.ssh/id_rsa.pub
  echo
  echo "Press enter to continue."
  confirm
  use_hiera=0
fi

puppet="/opt/puppetlabs/puppet/bin/puppet"
r10k="/opt/puppetlabs/puppet/bin/r10k"

${puppet:?} module install puppet/r10k --force

hiera_sources=""
if $(exit ${use_hiera:-1}); then
  hiera_sources="
'hiera' => {
  'remote'       => 'git@github.com:demophoon/hieradata.git',
  'basedir'=> '/opt/puppetlabs/hiera',
  'prefix'       => true,
}
"
fi

${puppet:?} apply -e "
class { 'r10k':
  sources => {
    'puppet' => {
      'remote' => 'https://github.com/demophoon/puppet-environment.git',
      'basedir'=> '/opt/puppetlabs/code/environments',
      'prefix' => false,
    },
    ${hiera_sources}
  },
}"

${r10k:?} deploy environment -pv
${puppet:?} apply --modulepath /etc/puppetlabs/code/environments/production/modules/ /etc/puppetlabs/code/environments/production/site.pp
