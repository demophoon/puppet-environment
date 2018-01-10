class profiles::machines::beryllium (){
  include nginx

  include profiles::components::plex

  include profiles::roles::development
  include profiles::roles::bolt
  include profiles::roles::mysql
  include profiles::roles::docker

  include profiles::roles::seedbox

  include profiles::roles::docker::owncloud
  include profiles::roles::docker::minio

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
    ],
  }

  class { 'profiles::components::jenkins':
    username => 'default',
    password => 'password',
  }

  profiles::components::webserver::vhost { 'Plex':
    vhosts => ['plex.home.brittg.com'],
    port   => 32400,
  }
  profiles::components::webserver::vhost { 'Minio':
    vhosts => ['minio.home.brittg.com', 's3.home.brittg.com', 'store.home.brittg.com'],
    port   => 9000,
  }
  profiles::components::webserver::vhost { 'Cloud':
    vhosts => ['cloud.home.brittg.com'],
    port   => 9263,
  }
  profiles::components::webserver::vhost { 'Consul-UI':
    vhosts => ['consul.home.brittg.com'],
    port   => 8500,
  }
  profiles::components::webserver::vhost { 'Jenkins':
    vhosts        => ['jenkins.home.brittg.com', 'jenkins.brittg.com'],
    port          => 8080,
    vhost_options => {
      proxy_redirect => 'http://127.0.0.1:8080 http://jenkins.brittg.com',
    }
  }
}
