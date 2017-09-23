#!/bin/bash

puppet="/opt/puppetlabs/puppet/bin/puppet"
r10k="/opt/puppetlabs/puppet/bin/r10k"

command_exists() {
    type "$1" &> /dev/null ;
}

install_puppet() {
    # Currently only supports ubuntu
    if command_exists dpkg; then
        source /etc/os-release
        codename=$(lsb_release -c | cut -f2)
        release_file="puppet5-release-${codename:?}.deb"
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

install_module() {
  module_name=${1:?}
  ${puppet:?} module install ${module_name:?}
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

install_module puppet/r10k

hiera_sources=""
if $(exit ${use_hiera:-1}); then
  hiera_sources="
'hiera' => {
  'remote'       => 'git@github.com:demophoon/hieradata.git',
  'basedir'      => '/etc/puppetlabs/puppet/hiera',
  'prefix'       => false,
}
"

  # We need to check if Github's ssh fingerprint is in known_hosts
  # First we fetch it from the server
  readonly github_fingerprint_tmp_file='/tmp/github-sshkey'
  ssh-keyscan github.com > ${github_fingerprint_tmp_file:?}

  # Next we have to test if fingerprint is already in known_hosts
  cat /root/.ssh/known_hosts | grep "$(cat /tmp/github-sshkey | awk '{print $3}' )"

  # If we do not have a fingerprint lets check the one we have to make sure we
  # are not being MITM'ed.
  if [ $? != 0 ]; then
    readonly github_fingerprint='16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48'
    if ssh-keygen -lf ${github_fingerprint_tmp_file:?} | awk '{print $2}' | grep ${github_fingerprint:?}; then
      cat ${github_fingerprint_tmp_file:?} >> /root/.ssh/known_hosts
    else
      echo "WARNING! GITHUB SSH FINGERPRINT DOES NOT MATCH. EXITING FOR SAFETY."
      exit 1
    fi
  fi
fi

${puppet:?} apply -e "
class { 'r10k':
  sources => {
    'puppet' => {
      'remote' => 'https://github.com/demophoon/puppet-environment.git',
      'basedir'=> '/etc/puppetlabs/code/environments',
      'prefix' => false,
    },
    ${hiera_sources}
  },
}"

${r10k:?} deploy environment -pv
${puppet:?} apply --modulepath /etc/puppetlabs/code/environments/production/modules/ /etc/puppetlabs/code/environments/production/site.pp
