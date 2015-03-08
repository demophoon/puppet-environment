class profiles::webserver {
    $latest_packages = [
        'fail2ban',
    ]

    package { $latest_packages:
        ensure => latest,
    }

    class { 'nginx': }

    # BrittG.com Resources
    nginx::resource::vhost { ['brittg.com', 'www.brittg.com']:
      proxy => 'http://localhost:2649',
    }
    nginx::resource::vhost { 'cards.brittg.com':
      proxy => 'http://localhost:3143',
    }
    nginx::resource::vhost { 'linode.brittg.com':
      www_root => '/var/www/',
    }
    nginx::resource::vhost { 'htdocs.brittg.com':
      www_root => '/var/www/htdocs/',
    }
    nginx::resource::vhost { 'music.brittg.com':
      www_root => '/var/www/htdocs/music/',
    }

    # www.revelation22.org Resources
    nginx::resource::vhost { 'www.revelation22.org':
      www_root => '/var/www/htdocs/revelation22/',
    }

    # www.mikhailmarchenko.com Resources
    nginx::resource::vhost { 'www.mikhailmarchenko.com':
      www_root => '/var/www/mm/',
    }

    # hakc.io Resources
    nginx::resource::vhost { ['hakc.io', 'www.hakc.io']:
      www_root => '/var/www/hakc/',
    }

    # OrderofDisArray.com Resources
    nginx::resource::vhost { ['www.orderofdisarray.com', 'orderofdisarray.com']:
      www_root => '/var/www/htdocs/disarray/',
    }

    # brittg.sexy Resources
    nginx::resource::vhost { 'www.brittg.sexy':
      proxy => 'http://localhost:2326',
    }
}
