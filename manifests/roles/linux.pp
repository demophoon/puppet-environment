class profiles::roles::linux (
) inherits profiles::params {
  include profiles::components::users
  include profiles::components::packages

  include profiles::roles::britt

  Package <| tag == 'global' |>

  class { 'ssh_hardening':
    ipv6_enabled => true,
    weak_kex     => true,
  }

  cron { ['puppet apply', 'r10k update environments']:
    ensure => absent,
  }

  profiles::components::symlinks { 'puppet': }
  profiles::components::symlinks { 'facter': }
  profiles::components::symlinks { 'hiera': }
}
