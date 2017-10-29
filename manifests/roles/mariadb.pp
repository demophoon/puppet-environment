class profiles::roles::mariadb () {
  class { 'mariadb::server':
    manage_user => true,
    uid         => 494,
    gid         => 494,
    shell       =>  '/sbin/nologin',
  }
}
