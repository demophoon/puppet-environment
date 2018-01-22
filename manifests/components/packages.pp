class profiles::components::packages {
  $global_packages = [
    'vim',
    'zsh',
    'bash',
    'ntp',
    'p7zip',
    'unzip',
    'tmux',
    'mercurial',
    'tree',
    'curl',
    'wget',
    'htop',
  ]

  $webserver_packages = [
      'fail2ban',
  ]

  @package { $global_packages:
    ensure => latest,
    tag    => ['global'],
  }

  @package { $webserver_packages:
    ensure => latest,
    tag    => ['webserver'],
  }

}

