class profiles::base {
  include profiles::components::users
  include profiles::components::packages

  User <| tag == 'global' |>
  Ssh_authorized_key <| tag == 'global' |>
  Package <| tag == 'global' |>

  class { 'ssh_hardening':
    ipv6_enabled => true,
    weak_kex     => true,
  }

  class { 'r10k':
    remote => 'https://github.com/demophoon/puppet-environment.git',
  }

  $puppet_bin_dir = $::clientversion ? {
    /4\.\d+\.\d+/ => '/opt/puppetlabs/puppet/bin',
    default       => '/usr/bin',
  }
  $puppet_code_dir = $::clientversion ? {
    /4\.\d+\.\d+/ => '/etc/puppetlabs/code',
    default       => '/etc/puppet',
  }

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
