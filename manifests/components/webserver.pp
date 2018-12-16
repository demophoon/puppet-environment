class profiles::components::webserver (
  $beryllium_ip = 'localhost',
) {
    include profiles::components::packages

    Package <| tag == 'webserver' |>

    include nginx

    # BrittG.com Resources

    profiles::components::webserver::vhost { 'minio':
      vhosts => ['s3.brittg.com'],
      proxy  => "http://${beryllium_ip}:9000",
      port   => 9000,
    }

    profiles::components::webserver::vhost { 'cloud':
      vhosts                => ['cloud.brittg.com', 'butt.brittg.com'],
      proxy                 => "http://${beryllium_ip}:9263",
      port                  => 9263,
      vhost_options         => {
        server_cfg_append => { 'rewrite' => '^/.well-known/webfinger /public.php?service=webfinger last' },
      }
    }

    profiles::components::webserver::vhost { 'shrls':
      vhosts => 'brittg.com',
      port   => 2649,
    }

    nginx::resource::location { "brittg.com/api":
      proxy    => 'http://10.0.0.1:3254',
      location => '/api/',
      server    => 'brittg.com',
    }

    nginx::resource::server { "www.brittg.com":
      www_root     => '/var/www/brittg/',
    }

    nginx::resource::location { "www.brittg.com/api":
      proxy    => 'http://10.0.0.1:3254',
      location => '/api/',
      server    => 'www.brittg.com',
    }

    nginx::resource::server { "tilde.demophoon.com":
      proxy            => "http://${beryllium_ip}:7844",
    }

    nginx::resource::server { "assets.brittg.com":
      www_root     => '/var/www/assets/',
    }

    nginx::resource::server { "resume.brittg.com":
      www_root     => '/var/www/assets/resume/',
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

    profiles::components::webserver::vhost { 'rss':
      vhosts => 'reader.brittg.com',
      port   => 8082,
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
