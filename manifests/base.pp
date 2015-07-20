class profiles::base {
  include profiles::users
  include profiles::packages

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

  $apply_environment = 'production'
  $apply_path = "/etc/puppet/environments/${apply_environment}"
  $apply_module_path = "${apply_path}/modules/"
  $site_pp = "${apply_path}/site.pp"

  $puppet_bin_dir = $::clientversion ? {
    /4\.\d+\.\d+/ => '/opt/puppetlabs/puppet/bin',
    default       => '/usr/bin',
  }

  cron { 'puppet apply':
    command => "${puppet_bin_dir}/puppet apply --modulepath ${apply_module_path} ${site_pp}",
    user    => 'root',
    minute  => ['0', '30'],
  }

  cron { 'r10k update environments':
    command => '/usr/local/bin/r10k deploy environment -pv',
    user    => 'root',
    minute  => ['15', '45'],
  }
}
