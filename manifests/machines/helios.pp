class profiles::machines::helios (){
  include profiles::roles::development
  include profiles::roles::development::hub

  include profiles::roles::yubikey
  include profiles::roles::docker

  apt::ppa { 'ppa:kelleyk/emacs': }

  package { [
    'cmus',
    'emacs26',
  ]:
    ensure  => present,
    require => Apt::Ppa['ppa:kelleyk/emacs'],
  }

  package { 'neovim': }
}
