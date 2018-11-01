class profiles::roles::apps::slack () {
  case $::osfamily {
    'Darwin': {
      package { 'slack':
        ensure   => 'present',
        provider => 'brewcask',
      }
    }
  }

  if $::facts['os']['name'] == 'Ubuntu' {
    include ::snapd
    package { 'slack':
      ensure   => latest,
      provider => 'snap',
    }
  }
}
