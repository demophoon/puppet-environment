class profiles::roles::docker::unifi() {
  require profiles::roles::docker

  file { '/tmp/unifi.docker/':
    ensure => 'directory',
    owner  => 'root',
    mode   => '600',
  }
  file { '/tmp/unifi.docker/docker-compose.yaml':
    ensure  => 'present',
    owner   => 'root',
    mode    => '600',
    content => template('profiles/docker/unifi.yaml.erb')
  }

  docker_compose { '/tmp/unifi.docker/docker-compose.yaml':
    ensure  => present,
    require => File['/tmp/unifi.docker/docker-compose.yaml'],
  }
}
