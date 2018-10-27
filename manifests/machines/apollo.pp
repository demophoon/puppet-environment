class profiles::machines::apollo (){
  include profiles::roles::development
  include profiles::roles::vpn
  include profiles::roles::wifi
  include profiles::roles::ansible
  include profiles::roles::nextcloud_client

  include profiles::roles::apps
  include profiles::roles::yubikey
  include profiles::roles::vagrant
  include profiles::roles::i3
  include profiles::roles::docker
  include profiles::roles::nfs::client
  include profiles::roles::media::client

  package { 'weechat':
    ensure => 'latest',
  }

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
    ],
  }

  apt::ppa { 'ppa:ubuntu-elisp/ppa': }

  package { [
    'cmus',
    'emacs25',
    'xserver-xorg-input-synaptics',
  ]:
    ensure  => present,
    require => Apt::Ppa['ppa:ubuntu-elisp/ppa'],
  }
}
