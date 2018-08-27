class profiles::components::matrix::synapse () {
  package { [
    'build-essential',
    'libffi-dev',
    'sqlite3',
    'libssl-dev',
    'python-virtualenv',
    'libjpeg-dev',
    'libxslt1-dev',
  ]:
    ensure => present,
  }

  python::virtualenv { '/opt/matrix_synapse':
    ensure  => present,
    version => '2.7',
  }

  python::pip { 'https://github.com/matrix-org/synapse/tarball/master':
    ensure     => present,
    virtualenv => '/opt/matrix_synapse',
  }
}
