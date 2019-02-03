class profiles::roles::i3 (
  Boolean $bluetooth = true,
) {
  include profiles::roles::i3::lock
  if $bluetooth {
    package {[
      'blueman',
    ]:
      ensure => 'present',
    }
  }

  package {[
    'i3',
    # i3 deps
    'feh',
    'lxappearance',
    'fonts-inconsolata',
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
