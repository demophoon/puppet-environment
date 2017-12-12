class profiles::roles::apps::keepass2 () {
  package { 'keepass2':
    ensure => 'present',
  }
}
