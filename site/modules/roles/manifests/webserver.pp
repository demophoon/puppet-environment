class roles::webserver {
    $latest_packages = [
        'fail2ban',
    ]

    package { $latest_packages:
        ensure => latest,
    }

    class { 'nginx': }

    # Just for testing
    nginx::resource::vhost { ['brittg.vm', 'www.brittg.vm']:
      www_root => '/var/www/',
    }

    nginx::resource::vhost { 'python.brittg.vm':
      proxy => 'http://localhost:8000',
    }
}
