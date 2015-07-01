class profiles::packages {
  $global_packages = [
    'vim',
    'zsh',
    'bash',
    'ntp',
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

