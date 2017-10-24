class profiles::roles::bolt () {
  package { 'bolt':
    ensure => latest,
    provider => 'puppet_gem',
  }

  profiles::components::symlinks { 'bolt': }
}
