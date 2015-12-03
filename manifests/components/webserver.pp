class profiles::components::webserver {
    include profiles::components::packages

    Package <| tag == 'webserver' |>

    include nginx

    # BrittG.com Resources
    nginx::resource::vhost { 'brittg.com':
      proxy => 'http://localhost:2649',
    }
    nginx::resource::vhost { 'www.brittg.com':
      www_root         => '/var/www/brittg/',
      ssl              => true,
      ssl_cert         => '/etc/letsencrypt/live/www.brittg.com/cert.pem',
      ssl_key          => '/etc/letsencrypt/live/www.brittg.com/privkey.pem',
      rewrite_to_https => true,
    }
    nginx::resource::vhost { 'cards.brittg.com':
      proxy => 'http://localhost:3143',
    }
    nginx::resource::vhost { 'assets.brittg.com':
      www_root => '/var/www/assets',
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
    nginx::resource::vhost { 'brittbot.brittg.com':
      www_root => '/var/www/htdocs/brittbot/',
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
