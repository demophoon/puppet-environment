class profiles::roles::docker () {
  class { 'docker': }
  class { 'docker::compose':
    ensure  => present,
    version => '1.18.0',
  }
}
