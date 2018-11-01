class profiles::roles::nextcloud_client (
  Optional[String] $username   = undef,
  Optional[String] $password   = undef,
  Optional[String] $server     = undef,
  Optional[String] $local_user = 'britt',
){
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
      } ->
      apt::ppa { 'ppa:nextcloud-devs/client':
        require => Apt::Key['nextcloud'],
        notify  => Exec['apt_update'],
      } ->
      package { 'nextcloud-client':
        ensure  => latest,
        require => [Apt::Ppa['ppa:nextcloud-devs/client'], Exec['apt_update']],
      }
      if $server != undef {
        package { 'libsecret-tools': } ->
        exec { 'Store Nextcloud Credentials':
          command => "echo '${password}' | secret-tool store --label='Nextcloud' server Nextcloud user '${username}:${server}' type plaintext",
          user    => $local_user,
          path    => '/bin:/usr/bin:/usr/local/bin',
          onlyif  => 'test -z "$(secret-tool search --all server Nextcloud)"',
        }
      }
    }
    default: {
      notify { 'Unable to install Nextcloud on this platform': }
    }
  }
}
