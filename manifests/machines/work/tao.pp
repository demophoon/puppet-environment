class profiles::machines::work::tao (){
  include profiles::roles::development
  include profiles::roles::wifi
  include profiles::roles::ansible
  include profiles::roles::nextcloud_client
  include profiles::roles::apps::slack
  include profiles::roles::apps::insomnia
  include profiles::roles::apps::vscode
  include profiles::roles::apps::discord
  include profiles::roles::development::hub

  include profiles::roles::apps
  include profiles::roles::apps::light
  include profiles::roles::yubikey
  include profiles::roles::vagrant
  include profiles::roles::i3
  include profiles::roles::linux::thinkpad
  include profiles::roles::docker

  apt::ppa { 'ppa:kelleyk/emacs': }

  class { 'hashicorp::terraform':
    version => '0.12.6',
  }

  package { [
    'cmus',
    'emacs26',
  ]:
    ensure  => present,
    require => Apt::Ppa['ppa:kelleyk/emacs'],
  }

  package { 'neovim':
  }

  package { ['python3-venv']:
  }
}
