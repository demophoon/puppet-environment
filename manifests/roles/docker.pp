class profiles::roles::docker () {
  class { 'docker': }
  class { 'docker::compose':
    ensure => present,
  }
}
