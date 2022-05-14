class profiles::machines::beryllium (){
  include profiles::roles::ansible
  include profiles::roles::development
  include profiles::roles::docker
  include profiles::roles::zfs
  include profiles::roles::media::server
  include profiles::roles::kubectl

  #include profiles::roles::docker::nextcloud
  #include profiles::roles::docker::minio
  #include profiles::roles::docker::plex
  #include profiles::roles::docker::homeassistant

  include profiles::roles::users::britt

  class { 'hashicorp::terraform':
    version => '0.12.6',
  }

  class { 'nginx':
    package_ensure => absent,
    service_ensure => stopped,
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
    vhosts => ['cloud.home.brittg.com', 'cloud.brittg.com'],
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

  nginx::resource::server { ["apt.cascadia.demophoon.com"]:
    www_root  => '/usr/share/nginx/html/apt/',
    autoindex => "on",
  }

  nginx::resource::server { ["www.britt.fm", "britt.fm"]:
    #www_root      => '/var/www/brittg/',
    proxy => 'http://127.0.0.1:5050',
  }

  nginx::resource::server { ["smartexam.cascadia.demophoon.com"]:
    proxy => 'http://127.0.0.1:12345',
  }

}
