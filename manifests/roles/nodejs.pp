class profiles::roles::nodejs () {
  class { '::nodejs':
    manage_package_repo       => false,
    nodejs_dev_package_ensure => 'present',
    npm_package_ensure        => 'present',
  }

  package { 'grunt-cli':
    ensure   => 'present',
    provider => 'npm',
    require  => Class['::nodejs'],
  }

  file { '/usr/bin/node':
    ensure  => link,
    target  => '/usr/bin/nodejs',
    require => Class['::nodejs'],
  }
}
