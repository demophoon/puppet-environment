class profiles::linode {
  include profiles::components::users
  User <| tag == 'linode' |>
  Ssh_authorized_key <| tag == 'linode' |>

  class { 'profiles::components::webserver': }

  class { 'profiles::components::consul':
    datacenter => hiera('datacenter', 'dc1'),
  }
}
