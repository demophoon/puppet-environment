class profiles::roles::docker::owncloud (
  $db_password = undef,
) {
  require profiles::roles::docker

  if ($db_password == undef) {
    warning('Unable to setup owncloud. Please set database password.')
  } else {
    file { '/tmp/owncloud.docker/':
      ensure => 'directory',
      owner  => 'root',
      mode   => '600',
    }
    file { '/tmp/owncloud.docker/docker-compose.yaml':
      ensure  => 'present',
      owner   => 'root',
      mode    => '600',
      content => template('profiles/docker/owncloud.yaml.erb')
    }

    docker_compose { '/tmp/owncloud.docker/docker-compose.yaml':
      ensure  => present,
      require => File['/tmp/owncloud.docker/docker-compose.yaml'],
    }
  }
}
