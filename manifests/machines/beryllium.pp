class profiles::machines::beryllium (){
  include nginx

  include profiles::roles::ansible
  include profiles::roles::development
  include profiles::roles::mysql
  include profiles::roles::docker
  include profiles::roles::zfs
  include profiles::roles::samba::server
  include profiles::roles::media::server
  include profiles::roles::certbot

  include profiles::roles::docker::nextcloud
  include profiles::roles::docker::minio
  include profiles::roles::docker::unifi
  include profiles::roles::docker::plex
  include profiles::roles::docker::homeassistant

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
    ],
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

  nginx::resource::server { ["www.britt.fm", "britt.fm"]:
    #www_root      => '/var/www/brittg/',
    proxy => 'http://127.0.0.1:5050',
  }

  nfs::server::export {'/tank0/backups':
    ensure  => present,
    clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) 192.168.1.0/24(rw,insecure,async,no_root_squash) localhost(rw)',
  }

}
