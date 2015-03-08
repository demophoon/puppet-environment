class profiles::base {
  $latest_packages = [
    'vim',
    'emacs',
    'zsh',
    'bash',
    'ntp',
  ]

  package { $latest_packages:
    ensure => latest,
  }

  class { 'r10k':
    remote => 'https://github.com/demophoon/puppet-environment.git',
  }

  cron { 'puppet apply':
    command => '/usr/bin/puppet apply /local/puppet/puppet-environment/manifests/site.pp',
    user => 'root',
    minute => ['0', '30'],
  }

  cron { 'r10k update environments':
    command => '/usr/local/bin/r10k deploy environment -pv',
    user => 'root',
    minute => ['15', '45'],
  }
}
