class profiles::roles::mac () inherits profiles::params {
  Package {
    provider => 'brew',
  }

  include profiles::components::packages
  Package <| tag == 'global' |>
}
