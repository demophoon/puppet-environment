class profiles::roles::linux::thinkpad () {

  package { [
    # Multitouch Gesture Support
    'xserver-xorg-input-libinput',
    'wmctrl',
    'libinput-tools',
    # pactl
    'pavucontrol',
    ]:
      ensure => 'present',
  } ->
  vcsrepo { '/opt/libinput-gestures':
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/bulletmark/libinput-gestures.git',
  } ~>
  exec { 'Install libinput-gestures':
    command     => 'libinput-gestures-setup install',
    path        => '/bin:/usr/bin:/usr/local/bin:/opt/libinput-gestures',
    cwd         => '/opt/libinput-gestures',
    refreshonly => true,
  }

}
