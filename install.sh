#!/bin/bash

puppet="/opt/puppetlabs/puppet/bin/puppet"
r10k="/opt/puppetlabs/puppet/bin/r10k"
environment=${ENVIRONMENT:-production}

case "$(uname -s)" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
esac


if [ -f '/etc/arch-release' ]; then
    # Arch doesn't have a puppet-agent package :(
    puppet='/usr/bin/puppet'
    r10k='/usr/bin/r10k'
fi

command_exists() {
    type "$1" &> /dev/null ;
}

resolve_codename() {
    codename=${1}
    case "${codename}" in
        cosmic) echo 'bionic' ;; # Treat 18.10 as 18.04 for testing purposes
        *) echo ${codename} ;;
    esac
}

install_puppet() {
    REPO_RELEASE='puppet5'
    # Currently only supports ubuntu
    if command_exists dpkg; then
        source /etc/os-release
        codename=$(lsb_release -c | cut -f2)
        codename=$(resolve_codename "${codename}")
        release_file="${REPO_RELEASE:?}-release-${codename:?}.deb"
        wget "https://apt.puppetlabs.com/${release_file:?}"
        dpkg -i ${release_file:?}
        rm ${release_file:?}
        apt-get update
        apt-get install puppet-agent -y
    elif command_exists yum; then
        source /etc/os-release
        release_file="${REPO_RELEASE:?}-release-el-${VERSION_ID:?}.noarch.rpm"
        rpm -Uvh "https://yum.puppetlabs.com/${release_file:?}"
        yum install puppet-agent -y
    elif [ -f '/etc/arch-release' ]; then
        pacman --sync ${REPO_RELEASE:?}
        ${puppet:?} apply -e "package {'r10k':
            ensure          => latest,
            provider        => 'gem',
            install_options => ['--bindir', '/usr/bin'],
        }"
    elif [ ${machine} = 'Mac' ]; then
        osx_version=$(sw_vers | grep ProductVersion | awk '{print $2}')
        version_parts=(${osx_version//./ })
        osx_version="${version_parts[0]}.${version_parts[1]}"
        dmg_file="puppet-agent-latest.dmg"
        curl -LO "https://downloads.puppetlabs.com/mac/${osx_version:?}/PC1/x86_64/${dmg_file}"
        hdiutil attach ${dmg_file:?}
        puppet_agent_mount=$(find /Volumes/ -type d -name 'puppet-agent*' -maxdepth 1)
        puppet_agent_pkg=$(find ${puppet_agent_mount:?} -type f -name '*.pkg')
        installer -package ${puppet_agent_pkg:?} -target /
        hdiutil detach ${puppet_agent_mount:?}
        rm -f ${dmg_file:?}
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
  response=${!1}
  if [ -z "${response}" ]; then
      read -p '> ' response
  else
      echo "> (Auto-response from \$$1) ${response}"
  fi
  echo
  if [[ ${response} =~ [yY] ]]; then
    return 0
  fi
  return 1
}

run_puppet() {
module_path="/etc/puppetlabs/code/environments/${environment}/modules/"
if [ -d "/etc/puppetlabs/code-private/environments/master/modules" ]; then
    module_path="${module_path}:/etc/puppetlabs/code-private/environments/master/modules"
fi
${r10k:?} deploy environment -pv
${puppet:?} apply --modulepath ${module_path} --environment ${environment} /etc/puppetlabs/code/environments/${environment}/site.pp
}

if [ ${UID} -ne 0 ]; then
  echo "This script must run as root to work properly."
  exit 1
fi

if ! command_exists /opt/puppetlabs/puppet/bin/puppet; then
    install_puppet
fi

if [ "${1}" = "run" ]; then
    run_puppet
    exit $?
fi

echo "Would you like to setup access to your hiera data repo? [y/N]"
echo "Warning: Only answer yes to this if you are Demophoon or have access to the private hiera data repo!"

if confirm PRIVATE_HIERADATA; then
  rootdir='/root'
  if [ ${machine} = 'Mac' ]; then
    rootdir='/var/root'
  fi
  if [ ! -f ${rootdir:?}/.ssh/id_rsa.pub ]; then
    echo "We couldn't find a ssh key in '${rootdir:?}/.ssh/'."
    echo "Would you like us to generate one? [y/N]"
    echo "Warning: Answering no may cause the install script to fail!"
    if confirm GEN_ROOT_SSH_KEY; then
      ssh-keygen -b 4096 -t rsa -f "${rootdir:?}/.ssh/id_rsa"
      echo
    fi
  fi
  echo "Add the following public key to the hiera data repo's deploy keys."
  echo
  cat ${rootdir:?}/.ssh/id_rsa.pub
  echo
  echo "Press enter to continue."
  confirm AUTO_CONFIRM
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
fi

if [ ${machine} = 'Mac' ]; then
    osx_user=${SUDO_USER:-root}
    if [ ${osx_user} = 'root' ]; then
        echo "Specify osx user account: "
        read -p '> ' osx_user
    fi

    install_module thekevjames-homebrew
    r10k_class='r10k::config'
    r10k_extra_params="root_group => 'wheel',"
    ${puppet:?} apply -e "
class { 'homebrew':
    user => '${osx_user:?}',
    multiuser => true,
}
package { 'r10k':
    provider => 'puppet_gem',
    ensure => '~>2',
}"
else
    r10k_class='r10k'
    r10k_extra_params=""
fi

${puppet:?} apply -e "
class { '${r10k_class:?}':
  ${r10k_extra_params}
  sources => {
    'puppet' => {
      'remote' => 'https://github.com/demophoon/puppet-environment.git',
      'basedir'=> '/etc/puppetlabs/code/environments',
      'prefix' => false,
    },
    ${hiera_sources}
  },
}"

run_puppet
