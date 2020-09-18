class profiles::roles::mac () inherits profiles::params {
  Package {
    provider => 'brew',
  }

  include profiles::roles::users::britt
  include profiles::components::packages

  Package <| tag == 'global' |>
}
