class profiles::machines::linodes::calico {
  require profiles::machines::linode

  include profiles::roles::docker
  include profiles::roles::sudoers
  include profiles::roles::docker::znc
  include profiles::roles::docker::ttrss

  include profiles::roles::nginx

  include profiles::roles::matrix

  include profiles::roles::nfs::client

  nginx::resource::server { ['mastodon-test.calico.demophoon.com']:
    proxy => 'https://localhost:3000',
  }

  nginx::resource::server { ['reader.brittg.com', 'reader.calico.demophoon.com']:
    proxy => 'http://localhost:5422',
  }

  nginx::resource::server { ['test.calico.demophoon.com']:
    proxy => 'http://localhost:1234',
  }

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
      '/opt/',
    ],
  }
}
