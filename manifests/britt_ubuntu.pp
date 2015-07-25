class profiles::britt_ubuntu {
  class { 'profiles::components::consul':
    datacenter => hiera('datacenter'),
    server     => true,
  }
}
