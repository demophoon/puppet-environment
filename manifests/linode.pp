class profiles::linode {
  include profiles::users
  User <| tag == 'linode' |>
  Ssh_authorized_key <| tag == 'linode' |>
}
