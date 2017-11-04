class profiles::beryllium (){
  include nginx
  include docker

  include profiles::components::plex

  include profiles::roles::development
  include profiles::roles::bolt
  include profiles::roles::mysql

  include profiles::roles::nodejs
  include profiles::roles::dicecloud

  include profiles::roles::seedbox

  class { 'profiles::components::jenkins':
    username => 'default',
    password => 'password',
  }
  class { 'profiles::components::consul':
    datacenter => hiera('datacenter'),
    server     => true,
  }

  profiles::components::webserver::vhost { 'Plex':
    vhosts => ['plex.home.brittg.com'],
    port   => 32400,
  }
  profiles::components::webserver::vhost { 'Consul UI':
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
