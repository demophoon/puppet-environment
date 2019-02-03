class profiles::machines::britt_pc () {
  include profiles::roles::wsl
  include apt

  include profiles::roles::britt
  include profiles::roles::development
  include profiles::roles::nextcloud_client
  include profiles::roles::apps
  include profiles::roles::i3

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

  apt::ppa { 'ppa:ubuntu-elisp/ppa': }

  package { [
    'cmus',
    'emacs25',
  ]:
    ensure  => present,
    require => Apt::Ppa['ppa:ubuntu-elisp/ppa'],
  }
}
