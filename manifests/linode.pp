class profiles::linode {
  include profiles::components::users
  User <| tag == 'tx.dc' |>
  Ssh_authorized_key <| tag == 'tx.dc' |>

  class { 'profiles::components::webserver': }
  class { 'profiles::components::consul':
    datacenter => lookup('datacenter', String, 'first', 'global'),
  }

  profiles::roles::backup { $::fqdn:
    backup_dirs => [
      '/home/',
      '/opt/',
      '/var/www/',
    ],
  }
}
