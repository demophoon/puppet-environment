class profiles::roles::apps::lutris () {
  case $::osfamily {
    'Debian': {
      $ensure = 'latest'
      apt::ppa { 'ppa:lutris-team/lutris':
        notify  => Exec['apt_update'],
      } ->
      package { 'lutris':
        ensure => $ensure,
      }

      apt::ppa { 'ppa:graphics-drivers/ppa':
        notify  => Exec['apt_update'],
      } ->
      package { 'nvidia-driver-418': }

      package { [
          'libvulkan1',
          'libvulkan1:i386',
        ]:
      }

    }
    default: {
      notify { "Lutris is not avaliable on ${::osfamily}": }
    }
  }
}
