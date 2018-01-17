class profiles::machines::linode {
  include profiles::components::users

  include profiles::roles::docker
  include profiles::roles::nfs::client
  include profiles::roles::media::client

  User <| tag == 'tx.dc' |>
  Ssh_authorized_key <| tag == 'tx.dc' |>

  class { 'profiles::components::webserver': }
  class { 'profiles::components::consul':
    datacenter => lookup('datacenter', String, 'first', 'global'),
  }

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
      '/opt/',
      '/var/www/',
    ],
  }
}
