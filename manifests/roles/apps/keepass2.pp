class profiles::roles::apps::keepass2 () {

  case $::osfamily {
    'Darwin': {
      $keepass2 = 'keepassxc'
      $opts = {}
    }
    'Debian': {
      case $facts['os']['release']['major'] {
        '20.04': {
          $additional_packages = ['xdotool']
          $opts = { provider => 'snap' }
        }
        '18.04': {
          $additional_packages = ['xdotool']
          $opts = { provider => 'snap' }
        }
        default: {
          $additional_packages = []
          $opts = {}
        }
      }
    }
    default: {
      $keepass2 = 'keepassxc'
      package { 'keepass2':
        ensure => absent,
      }
      $additional_packages = []
    }
  }

  package { $keepass2:
    * => $opts,
  }
  package { $additional_packages: }
}
