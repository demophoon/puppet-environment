class profiles::roles::linux (
) inherits profiles::params {
  include profiles::components::users
  include profiles::components::packages

  include profiles::roles::users::britt

  Package <| tag == 'global' |>

  class { 'ssh_hardening':
    ipv6_enabled           => true,
    weak_kex               => true,
    allow_agent_forwarding => true,
    allow_tcp_forwarding   => true,
  }

  cron { ['puppet apply', 'r10k update environments']:
    ensure => absent,
  }

  profiles::components::symlinks { 'puppet': }
  profiles::components::symlinks { 'facter': }
  profiles::components::symlinks { 'hiera': }
}
