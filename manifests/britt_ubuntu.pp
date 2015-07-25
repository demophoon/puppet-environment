class profiles::britt_ubuntu {
  class { 'profiles::components::consul':
    datacenter => hiera('datacenter'),
    server     => true,
  }

  class { 'nginx::config':
    vhost_purge => true,
  } ->
  class { 'nginx': }

  nginx::resource::vhost { 'vimtalk.brittg.com':
    proxy => 'http://localhost:9000',
  }
  nginx::resource::vhost { 'jenkins.brittg.com':
    proxy => 'http://localhost:8080',
  }
}
