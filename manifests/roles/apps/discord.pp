class profiles::roles::apps::discord () {
  include ::snapd
  package { 'discord':
    ensure   => latest,
    provider => 'snap',
  }
}

