class profiles::components::nextcloud_client (
  $user       = 'britt',
  $config_dir = "/home/${user}/.local/share/data/ownCloud",
) {
  apt::key { 'nextcloud':
    id     => '1FCD77DD0DBEF5699AD2610160EE47FBAD3DD469',
    server => 'keyserver.ubuntu.com',
  }
  apt::ppa { 'ppa:nextcloud-devs/client':
    require => Apt::Key['nextcloud'],
    notify  => Exec['apt_update'],
  }
  package { 'nextcloud-client':
    ensure  => latest,
    require => [Apt::Ppa['ppa:nextcloud-devs/client'], Exec['apt_update']],
  }
  # file { split($config_dir, '/'):
  #   ensure => directory,
  # }
  # file { "${config_dir}/owncloud.cfg":
  #   ensure  => file,
  #   owner   => $user,
  #   content => template(''),
  # }
}
