class profiles::components::webserver {
    include profiles::components::packages

    Package <| tag == 'webserver' |>

    include nginx

    # BrittG.com Resources
    letsencrypt_client::cert { "www.brittg.com":
      domains => [
        {
          webroot     => '/opt/shrls/uploads/',
          domain_name => 'brittg.com',
        },
        {
          webroot     => '/var/www/brittg/',
          domain_name => 'www.brittg.com',
        },
        {
          webroot     => '/var/www/assets/',
          domain_name => 'assets.brittg.com',
        },
        {
          webroot     => '/var/www/',
          domain_name => 'linode.brittg.com',
        },
        {
          webroot     => '/var/www/htdocs/',
          domain_name => 'htdocs.brittg.com',
        },
        {
          webroot     => '/var/www/htdocs/brittbot/',
          domain_name => 'brittbot.brittg.com',
        },
        {
          webroot     => '/var/www/htdocs/music/',
          domain_name => 'music.brittg.com',
        },
      ]
    }

    nginx::resource::vhost { "brittg.com":
      proxy            => 'http://localhost:2649',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/www.brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/www.brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["www.brittg.com"],
    }

    nginx::resource::vhost { "www.brittg.com":
      www_root         => '/var/www/brittg/',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/www.brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/www.brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["www.brittg.com"],
    }

    nginx::resource::vhost { "assets.brittg.com":
      www_root         => '/var/www/assets/',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/www.brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/www.brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["www.brittg.com"],
    }

    nginx::resource::vhost { "linode.brittg.com":
      www_root         => '/var/www/',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/www.brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/www.brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["www.brittg.com"],
    }

    nginx::resource::vhost { "htdocs.brittg.com":
      www_root         => '/var/www/htdocs',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/www.brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/www.brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["www.brittg.com"],
    }

    nginx::resource::vhost { "brittbot.brittg.com":
      www_root         => '/var/www/htdocs/brittbot',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/www.brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/www.brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["www.brittg.com"],
    }

    nginx::resource::vhost { "music.brittg.com":
      www_root         => '/var/www/htdocs/music',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/www.brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/www.brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["www.brittg.com"],
    }

    nginx::resource::vhost { 'cards.brittg.com':
      proxy => 'http://localhost:3143',
    }
    nginx::resource::vhost { 'reader.brittg.com':
      proxy => 'http://localhost:8082',
    }

    # www.revelation22.org Resources
    nginx::resource::vhost { 'www.revelation22.org':
      www_root => '/var/www/htdocs/revelation22/',
    }

    # www.mikhailmarchenko.com Resources
    nginx::resource::vhost { 'www.mikhailmarchenko.com':
      www_root => '/var/www/mm/',
    }

    # vim.brittg.com Resources
    nginx::resource::vhost { 'vim.brittg.com':
      proxy => 'http://localhost:2326',
    }
}
