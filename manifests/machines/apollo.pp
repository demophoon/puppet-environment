class profiles::machines::apollo (){
  include profiles::roles::development
  include profiles::roles::vpn
  include profiles::roles::wifi
  include profiles::roles::ansible
  include profiles::roles::nextcloud_client
  include profiles::roles::apps::slack
  include profiles::roles::apps::insomnia
  include profiles::roles::apps::vscode
  include profiles::roles::apps::asciinema
  include profiles::roles::apps::lutris
  include profiles::roles::apps::anbox
  include profiles::roles::apps::discord
  include profiles::roles::apps::yakyak
  include profiles::roles::development::hub

  include profiles::roles::apps
  include profiles::roles::apps::light
  include profiles::roles::yubikey
  include profiles::roles::vagrant
  include profiles::roles::i3
  include profiles::roles::linux::thinkpad
  include profiles::roles::docker
  include profiles::roles::nfs::client
  include profiles::roles::media::client

  package { [
    'weechat',
    'xscreensaver',
    'xscreensaver-data',
    'xscreensaver-gl',
    'xscreensaver-data-extra',
    'xscreensaver-gl-extra',
  ]:
    ensure => 'latest',
  }

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
    ],
  }

  apt::ppa { 'ppa:kelleyk/emacs': }

  package { [
    'cmus',
    'emacs26',
  ]:
    ensure  => present,
    require => Apt::Ppa['ppa:kelleyk/emacs'],
  }

  apt::ppa { 'ppa:team-gcc-arm-embedded/ppa':
    notify => Exec['apt_update'],
  } ->
  package { 'gcc-arm-embedded': }

  package { 'neovim': }

  package { ['rxvt-unicode', 'autocutsel']: }
}
