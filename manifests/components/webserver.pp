class profiles::components::webserver {
    include profiles::components::packages

    Package <| tag == 'webserver' |>

    include nginx

    # BrittG.com Resources
    letsencrypt_client::cert { "brittg.com":
      domains => [
        {
          webroot     => '/opt/shrls/uploads/',
          domain_name => 'brittg.com',
        },
        {
          webroot     => '/var/www/brittg/',
          domain_name => 'www.brittg.com',
        },
      ]
    }

    nginx::resource::vhost { "brittg.com":
      proxy            => 'http://localhost:2649',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["brittg.com"],
    }

    nginx::resource::vhost { "www.brittg.com":
      www_root         => '/var/www/brittg/',
      ssl              => true,
      ssl_cert         => "/etc/letsencrypt/live/brittg.com/fullchain.pem",
      ssl_key          => "/etc/letsencrypt/live/brittg.com/privkey.pem",
      rewrite_to_https => true,
      require          => Letsencrypt_client::Cert["brittg.com"],
    }

    nginx::resource::vhost { 'cards.brittg.com':
      proxy => 'http://localhost:3143',
    }
    profiles::components::webserver::ssl_vhost { 'assets.brittg.com':
      www_root => '/var/www/assets/',
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
    profiles::components::webserver::ssl_vhost { 'brittbot.brittg.com':
      www_root => '/var/www/htdocs/brittbot/',
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
