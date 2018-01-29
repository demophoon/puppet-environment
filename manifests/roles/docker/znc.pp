class profiles::roles::docker::znc (
  $znc_port = undef,
) {
  require profiles::roles::docker

  if ($znc_port == undef) {
    warning('Unable to setup znc. Please set $znc_port.')
  } else {
    file { '/tmp/znc.docker/':
      ensure => 'directory',
      owner  => 'root',
      mode   => '600',
    }
    file { '/tmp/znc.docker/docker-compose.yml':
      ensure  => 'present',
      owner   => 'root',
      mode    => '600',
      content => template('profiles/docker/znc.yml.erb')
    }

    docker_compose { '/tmp/znc.docker/docker-compose.yml':
      ensure  => present,
      require => File['/tmp/znc.docker/docker-compose.yml'],
    }
  }
}
