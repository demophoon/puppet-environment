class profiles::roles::apps::insomnia () {
  include ::snapd
  package { 'insomnia':
    ensure   => latest,
    provider => 'snap',
  }
}
