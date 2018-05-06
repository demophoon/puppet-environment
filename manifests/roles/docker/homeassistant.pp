class profiles::roles::docker::homeassistant(
  $ha_key = 'welcome',
) {
  require profiles::roles::docker

  file { '/tmp/homeassistant.docker/':
    ensure => 'directory',
    owner  => 'root',
    mode   => '600',
  }
  file { '/tmp/homeassistant.docker/docker-compose.yaml':
    ensure  => 'present',
    owner   => 'root',
    mode    => '600',
    content => template('profiles/docker/homeassistant.yaml.erb')
  }

  docker_compose { '/tmp/homeassistant.docker/docker-compose.yaml':
    ensure  => present,
    require => File['/tmp/homeassistant.docker/docker-compose.yaml'],
  }
}
