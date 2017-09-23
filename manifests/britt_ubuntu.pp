class profiles::britt_ubuntu (
  Array[Hash] $mounts = [],
){
  class { 'profiles::components::consul':
    datacenter => hiera('datacenter'),
    server     => true,
  }

  include nginx

  nginx::resource::vhost { ['britt-ubuntu.home.brittg.com']:
    proxy => 'http://localhost:8500',
  }
  nginx::resource::vhost { ['vimtalk.home.brittg.com', 'vimtalk.brittg.com']:
    proxy => 'http://localhost:9000',
  }
  nginx::resource::vhost { ['jenkins.home.brittg.com', 'jenkins.brittg.com']:
    proxy          => 'http://127.0.0.1:8080',
    proxy_redirect => 'http://127.0.0.1:8080 http://jenkins.brittg.com',
  }

  $mounts.each [String $name, $params] {
    mount { $name:
      ensure => present,
      *      => $params,
    }
  }

}
