class profiles::roles::apps::firefox () {
  package { 'firefox':
    ensure => 'latest',
  }
}
