class profiles::components::webserver {
    include profiles::components::packages

    Package <| tag == 'webserver' |>

    include nginx

    # BrittG.com Resources
    nginx::resource::server { "brittg.com":
      proxy        => 'http://localhost:2649',
    }

    nginx::resource::location { "brittg.com/api":
      proxy    => 'http://localhost:3254',
      location => '/api/',
      server    => 'brittg.com',
    }

    nginx::resource::server { "www.brittg.com":
      www_root     => '/var/www/brittg/',
    }

    nginx::resource::location { "www.brittg.com/api":
      proxy    => 'http://localhost:3254',
      location => '/api/',
      server    => 'www.brittg.com',
    }

    nginx::resource::server { "tilde.demophoon.com":
      proxy            => 'http://192.168.1.4:7844',
    }

    nginx::resource::server { "assets.brittg.com":
      www_root     => '/var/www/assets/',
    }

    nginx::resource::server { "linode.brittg.com":
      www_root     => '/var/www/',
    }

    nginx::resource::server { "htdocs.brittg.com":
      www_root     => '/var/www/htdocs',
    }

    nginx::resource::server { "brittbot.brittg.com":
      www_root     => '/var/www/htdocs/brittbot',
    }

    nginx::resource::server { "music.brittg.com":
      www_root     => '/var/www/htdocs/music',
    }

    nginx::resource::server { 'cards.brittg.com':
      proxy => 'http://localhost:3143',
    }
    nginx::resource::server { 'reader.brittg.com':
      proxy => 'http://localhost:8082',
    }

    # www.revelation22.org Resources
    nginx::resource::server { 'www.revelation22.org':
      www_root => '/var/www/htdocs/revelation22/',
    }

    # www.mikhailmarchenko.com Resources
    nginx::resource::server { 'www.mikhailmarchenko.com':
      www_root => '/var/www/mm/',
    }

    # vim.brittg.com Resources
    nginx::resource::server { 'vim.brittg.com':
      proxy => 'http://localhost:2326',
    }
}
