class profiles::roles::vpn () {
  File {
    mode   => '0600',
    owner  => 'root',
    group  => 'root',
  }

  package { ['openvpn', 'easy-rsa']:
    ensure => present
  }

  file { '/opt/vpn/':
    ensure => directory,
  }
  file { '/opt/vpn/ca.crt':
    ensure  => present,
    source => 'puppet:///modules/profiles/vpn/ca.crt',
  }
  file { '/opt/vpn/dh2048.crt':
    ensure  => present,
    source => 'puppet:///modules/profiles/vpn/dh2048.pem',
  }
}
