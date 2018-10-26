class profiles::roles::apps::keepass2 () {
  case $::osfamily {
    'Darwin': { $keepass2 = 'keepassxc' }
    default: { $keepass2 = 'keepass2' }
  }

  case $::osfamily {
    'Debian': {
      case $facts['os']['release']['major'] {
        '18.04': { $additional_packages = ['xdotool'] }
        default: { $additional_packages = [] }
      }
    }
    default: {
      $additional_packages = []
    }
  }

  package { $keepass2: }
  package { $additional_packages: }
}
