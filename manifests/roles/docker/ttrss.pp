class profiles::roles::docker::ttrss (
  $db_password = undef,
) {
  require profiles::roles::docker

  if ($db_password == undef) {
    warning('Unable to setup Tiny Tiny RSS. Please set database password.')
  } else {
    file { '/tmp/ttrss.docker/':
      ensure => 'directory',
      owner  => 'root',
      mode   => '600',
    }
    file { '/tmp/ttrss.docker/docker-compose.yaml':
      ensure  => 'present',
      owner   => 'root',
      mode    => '600',
      content => template('profiles/docker/ttrss.yaml.erb')
    }

    docker_compose { '/tmp/ttrss.docker/docker-compose.yaml':
      ensure  => present,
      require => File['/tmp/ttrss.docker/docker-compose.yaml'],
    }
  }
}
