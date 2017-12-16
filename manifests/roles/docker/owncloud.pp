class profiles::roles::docker::owncloud () {
  exec {'start_owncloud':
    command => "/usr/bin/docker run -p 9263:80 -v /media/tb-tb/owncloud/:/var/www/html:rw -itd owncloud",
    unless  => "/usr/bin/docker ps | /bin/grep -q owncloud",
    path    => '/usr/bin:/bin',
  }
}
