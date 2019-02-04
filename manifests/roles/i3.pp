class profiles::roles::i3 (
  Boolean $bluetooth = true,
  Boolean $extras = true,
) {
  include profiles::roles::i3::lock
  if $bluetooth {
    package {[
      'blueman',
    ]:
      ensure => 'present',
    }
  }

  if $extras {
    package {[
      'shutter',
    ]:
      ensure => 'present',
    }
  }

  package {[
    'i3',
    # i3 deps
    'gnome-terminal',
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
