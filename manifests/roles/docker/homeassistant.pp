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

  udev::rule { 'zwave.rules':
    ensure  => present,
    content => 'ACTION=="add", SUBSYSTEMS=="usb-serial", ATTRS{interface}=="HubZ Z-Wave Com Port", SYMLINKS+="zwave"',
    notify  => [
      Class['udev::udevadm::trigger'],
      Docker_compose['/tmp/homeassistant.docker/docker-compose.yaml']
    ],
  }
  udev::rule { 'zigbee.rules':
    ensure  => present,
    content => 'ACTION=="add", SUBSYSTEMS=="usb-serial", ATTRS{interface}=="HubZ ZigBee Com Port", SYMLINKS+="zigbee"',
    notify  => [
      Class['udev::udevadm::trigger'],
      Docker_compose['/tmp/homeassistant.docker/docker-compose.yaml']
    ],
  }
}
