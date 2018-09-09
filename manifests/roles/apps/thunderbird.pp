class profiles::roles::apps::thunderbird () {
  $thunderbird = 'thunderbird'
  case $::osfamily {
    'Darwin': {
      $ensure = 'present'
    }
    'Debian': {
      $ensure = 'latest'
      apt::ppa { 'ppa:ubuntu-mozilla-security/ppa': }
    }
    default: {
      $ensure = 'latest'
    }
  }
  package { $thunderbird:
    ensure => $ensure,
  }
}
