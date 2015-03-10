class profiles::base {
  $latest_packages = [
    'vim',
    'zsh',
    'bash',
    'ntp',
  ]

  package { $latest_packages:
    ensure => latest,
  }

  user { 'britt':
    ensure => present,
    home   => '/home/britt/',
    shell  => '/bin/zsh',
  }

  class { 'r10k':
    remote => 'https://github.com/demophoon/puppet-environment.git',
  }

  $apply_module_path = '/etc/puppet/environments/production/modules/'
  $site_pp = "${apply_module_path}profiles/manifests/site.pp"

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
