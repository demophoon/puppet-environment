class profiles::roles::mac () inherits profiles::params {
  Package {
    provider => 'brew',
  }

  package { 'vim':
    ensure => present,
  }
}
