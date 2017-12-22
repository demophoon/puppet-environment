class profiles::machines::raspberrypi {
  include profiles::base
  include nginx

  $latest_packages = [
    'gphoto2',
    'python',
  ]

  package { $latest_packages:
    ensure => latest,
  }
}

