class profiles::roles::apps::yakyak () {
  case $::osfamily {
    'Debian': {
      include ::snapd
      package { 'yakyak':
        ensure   => latest,
        provider => 'snap',
      }
    }
  }
}
