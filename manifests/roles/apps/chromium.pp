class profiles::roles::apps::chromium () {
  package { 'chromium-browser':
    ensure => 'present',
  }
}
