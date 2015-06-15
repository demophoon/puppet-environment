class profiles::base {
  include profiles::users

  $latest_packages = [
    'vim',
    'zsh',
    'bash',
    'ntp',
  ]

  User <| tag == 'global' |>
  Ssh_authorized_key <| tag == 'global' |>

  package { $latest_packages:
    ensure => latest,
  }

  class { 'r10k':
    remote => 'https://github.com/demophoon/puppet-environment.git',
  }

  $apply_environment = 'production'
  $apply_path = "/etc/puppet/environments/${apply_environment}"
  $apply_module_path = "${apply_path}/modules/"
  $site_pp = "${apply_path}/site.pp"

  cron { 'puppet apply':
    command => "/usr/bin/puppet apply --modulepath ${apply_module_path} ${site_pp}",
    user    => 'root',
    minute  => ['0', '30'],
  }

  cron { 'r10k update environments':
    command => '/usr/local/bin/r10k deploy environment -pv',
    user    => 'root',
    minute  => ['15', '45'],
  }
}
