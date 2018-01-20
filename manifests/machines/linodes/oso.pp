class profiles::machines::linodes::oso {
  require profiles::machines::linode

  include profiles::roles::docker
  include profiles::roles::nfs::client
  include profiles::roles::media::client

  User <| tag == 'tx.dc' |>
  Ssh_authorized_key <| tag == 'tx.dc' |>

  class { 'profiles::components::webserver': }

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
      '/opt/',
      '/var/www/',
    ],
  }
  include profiles::roles::docker
  include profiles::roles::nfs::client
  include profiles::roles::media::client

  User <| tag == 'tx.dc' |>
  Ssh_authorized_key <| tag == 'tx.dc' |>

  class { 'profiles::components::webserver': }

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
      '/opt/',
      '/var/www/',
    ],
  }
}
