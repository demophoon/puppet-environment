class profiles::roles::apps::slack () {
  case $::osfamily {
    'Darwin': {
      package { 'slack':
        ensure   => 'present',
        provider => 'brewcask',
      }
    }
  }
}
