class profiles::components::matrix::synapse () {

  class { 'python' :
    ensure      => 'present',
    dev         => 'present',
    virtualenv  => 'present',
  }

  package { [
    'build-essential',
    'libffi-dev',
    'sqlite3',
    'libssl-dev',
    'libjpeg-dev',
    'libxslt1-dev',
  ]:
    ensure => present,
  }

  python::virtualenv { '/opt/matrix_synapse':
    ensure  => present,
    version => 'system',
  }

  python::pip { 'https://github.com/matrix-org/synapse/tarball/master':
    ensure     => present,
    virtualenv => '/opt/matrix_synapse',
  }
}
