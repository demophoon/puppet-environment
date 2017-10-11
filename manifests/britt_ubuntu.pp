class profiles::britt_ubuntu (){
  include nginx

  include profiles::components::plex
  class { 'profiles::components::consul':
    datacenter => hiera('datacenter'),
    server     => true,
  }

  nginx::resource::server { ["britt-ubuntu.home.brittg.com"]:
    proxy => 'http://localhost:8500',
  }
  nginx::resource::server { ['vimtalk.home.brittg.com', 'vimtalk.brittg.com']:
    proxy => 'http://localhost:9000',
  }
  nginx::resource::server { ['jenkins.home.brittg.com', 'jenkins.brittg.com']:
    proxy          => 'http://127.0.0.1:8080',
    proxy_redirect => 'http://127.0.0.1:8080 http://jenkins.brittg.com',
  }

}
