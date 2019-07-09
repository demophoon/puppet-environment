class profiles::roles::docker::pihole (
) {
  require profiles::roles::docker

  file { '/tmp/pihole.docker/':
    ensure => 'directory',
    owner  => 'root',
    mode   => '600',
  }
  file { '/tmp/pihole.docker/docker-compose.yaml':
    ensure  => 'present',
    owner   => 'root',
    mode    => '600',
    content => template('profiles/docker/pihole.yaml.erb')
  }

  docker_compose { '/tmp/pihole.docker/docker-compose.yaml':
    ensure  => present,
    require => File['/tmp/pihole.docker/docker-compose.yaml'],
  }
}
