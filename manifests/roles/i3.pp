class profiles::roles::i3 () {
  include profiles::roles::i3::lock

  package {[
    'i3',
    # i3 deps
    'feh',
    'lxappearance',
    'fonts-inconsolata',
    'blueman',
    'rofi',
    'gtk-chtheme',
    'qt4-qtconfig',
  ]:
    ensure => 'present',
  }

  package { 'py3status':
    ensure   => 'present',
    provider => 'pip3',
  }
}
