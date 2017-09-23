class profiles::base (
  Hash    $additional_r10k_sources = {},
  String  $hiera_private_key       = '/root/.ssh/id_rsa',

  Boolean $use_hiera               = $profiles::params::use_hiera,
) inherits profiles::params {
  include profiles::components::users
  include profiles::components::packages

  Package <| tag == 'global' |> ->
  User <| tag == 'global' |> ->
  Ssh_authorized_key <| tag == 'global' |>

  class { 'ssh_hardening':
    ipv6_enabled => true,
    weak_kex     => true,
  }

  $default_r10k_sources = {
    'puppet' => {
      'remote' => 'https://github.com/demophoon/puppet-environment.git',
      'prefix' => false,
    }
  }

  # We need to make sure we have a key so we at least have a chance at authenticating against the repo
  if $use_hiera and file_exists($hiera_private_key) {
    $default_hiera_sources = {
      'hiera' => {
        'remote'       => 'git@github.com:demophoon/hieradata.git',
        'prefix'       => true,
        'git_settings' => {
          'private_key' => $hiera_private_key,
        },
      }
    }
  } else {
    $default_hiera_sources = {}
  }

  $r10k_source_defaults = deep_merge($default_r10k_sources, $default_hiera_sources)
  $r10k_sources = deep_merge($r10k_source_defaults, $additional_r10k_sources)

  class { 'r10k':
    sources    => $r10k_sources,
    modulepath => "${::settings::confdir}/environments/\$environment/modules:/opt/puppet/share/puppet/modules",
  }

  $puppet_bin_dir = "${::settings::confdir}/bin"
  $puppet_code_dir = '/etc/puppetlabs/code'

  $apply_path = "${puppet_code_dir}/environments/${::environment}"
  $apply_module_path = "${apply_path}/modules/"
  $site_pp = "${apply_path}/site.pp"

  cron { 'puppet apply':
    command => "${puppet_bin_dir}/puppet apply --modulepath ${apply_module_path} ${site_pp}",
    user    => 'root',
    minute  => ['0', '30'],
  }

  cron { 'r10k update environments':
    command => '/opt/puppetlabs/puppet/bin/r10k deploy environment -pv',
    user    => 'root',
    minute  => ['15', '45'],
  }

  profiles::components::symlinks { 'puppet': }
  profiles::components::symlinks { 'facter': }
  profiles::components::symlinks { 'hiera': }
}
