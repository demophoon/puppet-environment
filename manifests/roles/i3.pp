class profiles::roles::i3 (
  Boolean $bluetooth = true,
  Boolean $extras = true,
  Boolean $regolith = false,
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
      'qrencode',
      'redshift',
      'xclip',
      'compton',
    ]:
      ensure => 'present',
    }
  }

  if $regolith {
    apt::ppa { 'ppa:regolith-linux/release': } ->
    package { [
      'regolith-desktop',
      'i3xrocks-net-traffic',
      'i3xrocks-cpu-usage',
      'i3xrocks-time',
    ]:
      ensure => 'present',
    }
  } else {
    package { 'i3':
      ensure => 'present',
    }
  }

  package {[
    # i3 deps
    'gnome-terminal',
    'feh',
    'lxappearance',
    'fonts-inconsolata',
    'rofi',
    'gtk-chtheme',
    'qt4-qtconfig',
    'rxvt-unicode',
    'autocutsel',
  ]:
    ensure => 'present',
  }

  package { 'py3status':
    ensure   => 'present',
    provider => 'pip3',
  }
}
