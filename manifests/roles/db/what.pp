class profiles::roles::db::what () {
  ::mysql::db { 'what_cd':
    user     => 'username',
    password => 'password',
    host     => 'localhost',
    grant    => ['ALL'],
  }
}
