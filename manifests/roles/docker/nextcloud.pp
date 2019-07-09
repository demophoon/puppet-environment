class profiles::roles::docker::nextcloud (
  $db_password = undef,
  $root_db_password = undef,
) {
  require profiles::roles::docker

  if ($db_password == undef or $root_db_password == undef) {
    warning('Unable to setup nextcloud. Please set database password.')
  } else {
    file { '/tmp/nextcloud.docker/':
      ensure => 'directory',
      owner  => 'root',
      mode   => '600',
    }
    file { '/tmp/nextcloud.docker/docker-compose.yaml':
      ensure  => 'present',
      owner   => 'root',
      mode    => '600',
      content => template('profiles/docker/nextcloud.yaml.erb')
    }

    docker_compose { '/tmp/nextcloud.docker/docker-compose.yaml':
      ensure  => present,
      require => File['/tmp/nextcloud.docker/docker-compose.yaml'],
    }
  }
}
