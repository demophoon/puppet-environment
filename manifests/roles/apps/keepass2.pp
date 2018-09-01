class profiles::roles::apps::keepass2 () {
  case $::osfamily {
    'Darwin': { $keepass2 = 'keepassxc' }
    default: { $keepass2 = 'keepass2' }
  }
  package { $keepass2: }
}
