class profiles::machines::linodes::oso {
  require profiles::machines::linode

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
