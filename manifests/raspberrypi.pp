class profiles::raspberrypi {
  include profiles::base

  class { 'nginx': }

  $latest_packages = [
    'gphoto2',
    'python',
  ]

  package { $latest_packages:
    ensure => latest,
  }
}

