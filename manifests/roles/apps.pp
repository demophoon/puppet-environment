class profiles::roles::apps () {
  case $::osfamily {
    'Darwin': {
      Package {
        ensure   => 'present',
        provider => 'brewcask',
      }
    }
    default: {
      Package {
        ensure => 'latest',
      }
    }
  }

  include profiles::roles::apps::chromium
  include profiles::roles::apps::firefox
  include profiles::roles::apps::keepass2
}
