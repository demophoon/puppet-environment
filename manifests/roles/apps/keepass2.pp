class profiles::roles::apps::keepass2 () {

  $keepass2 = 'keepassxc'
  case $::osfamily {
    'Darwin': {
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
      package { 'keepass2':
        ensure => absent,
      }
      $additional_packages = []
      $opts = {}
    }
  }

  package { $keepass2:
    * => $opts,
  }
  package { $additional_packages: }
}
