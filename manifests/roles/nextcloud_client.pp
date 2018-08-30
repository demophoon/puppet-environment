class profiles::roles::nextcloud_client {
  case $::osfamily {
    /Darwin/: {
      package { 'nextcloud':
        ensure   => latest,
        provider => 'brewcask',
      }
    }
    /Debian/: {
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
    }
    default: {
      notify { 'Unable to install Nextcloud on this platform': }
    }
  }
}
