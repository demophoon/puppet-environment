class profiles::roles::linux (
  Hash    $additional_r10k_sources = {},
  String  $hiera_private_key       = '/root/.ssh/id_rsa',
) inherits profiles::params {
  include profiles::components::users
  include profiles::components::packages

  include profiles::roles::britt
  include profiles::roles::masterless

  Package <| tag == 'global' |>

  class { 'ssh_hardening':
    ipv6_enabled => true,
    weak_kex     => true,
  }

  # We need to make sure we have a key so we at least have a chance at authenticating against the repo
  if enable_private_hiera() {
    class { 'hiera':
      hiera_version  => '5',
      hiera5_defaults => {
        'datadir'   => "${::settings::confdir}/hiera/master/",
        'data_hash' => 'yaml_data',
      },
      hierarchy      => [
        { 'name' => 'Node', 'path' => 'nodes/%{fqdn}.yaml' },
        { 'name' => 'Environment', 'path' => 'environments/%{environment}.yaml' },
        { 'name' => 'Global', 'path' => 'global.yaml' },
      ],
    }
  }

  cron { ['puppet apply', 'r10k update environments']:
    ensure => absent,
  }

  profiles::components::symlinks { 'puppet': }
  profiles::components::symlinks { 'facter': }
  profiles::components::symlinks { 'hiera': }
}
