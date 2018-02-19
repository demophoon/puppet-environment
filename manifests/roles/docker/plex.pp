class profiles::roles::docker::plex() {
  require profiles::roles::docker

  file { '/tmp/plex.docker/':
    ensure => 'directory',
    owner  => 'root',
    mode   => '600',
  }
  file { '/tmp/plex.docker/docker-compose.yaml':
    ensure  => 'present',
    owner   => 'root',
    mode    => '600',
    content => template('profiles/docker/plex.yaml.erb')
  }

  docker_compose { '/tmp/plex.docker/docker-compose.yaml':
    ensure  => present,
    require => File['/tmp/plex.docker/docker-compose.yaml'],
  }
}
