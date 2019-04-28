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
    }
    default: {
      notify { "Lutris is not avaliable on ${::osfamily}": }
    }
  }
}
