class profiles::roles::zfs () {

  case $::osname {
    'Debian': {
      apt::setting { 'conf-validity':
        content => @(EOS/L),
        Acquire::Check-Valid-Until "false";
        | EOS
      }
      class { '::apt::backports':
        location => 'http://archive.debian.org/debian',
        pin      => 500,
      }
      apt::source { 'contrib':
        location => 'http://deb.debian.org/debian',
        repos    => 'contrib',
      }
      include ::zfs
    }
    'Ubuntu': {
      package { 'zfsutils-linux':
        ensure => 'present',
      }
    }
  }

  zfs { 'dank0':
    ensure         => 'present',
    aclinherit     => 'restricted',
    aclmode        => '-',
    atime          => 'on',
    canmount       => 'on',
    checksum       => 'on',
    compression    => 'off',
    copies         => '1',
    dedup          => 'off',
    devices        => 'on',
    exec           => 'on',
    logbias        => 'latency',
    mountpoint     => '/tank0',
    nbmand         => 'off',
    primarycache   => 'all',
    quota          => 'none',
    readonly       => 'off',
    recordsize     => '128K',
    refquota       => 'none',
    refreservation => 'none',
    reservation    => 'none',
    secondarycache => 'all',
    setuid         => 'on',
    shareiscsi     => '-',
    sharenfs       => 'off',
    sharesmb       => 'off',
    snapdir        => 'hidden',
    version        => '5',
    volsize        => '-',
    vscan          => 'off',
    xattr          => 'on',
    zoned          => 'off',
  }

  zfs { 'dank0/andromeda':
    ensure         => 'present',
    aclinherit     => 'restricted',
    aclmode        => '-',
    atime          => 'on',
    canmount       => 'on',
    checksum       => 'on',
    compression    => 'on',
    copies         => '1',
    dedup          => 'off',
    devices        => 'on',
    exec           => 'on',
    logbias        => 'latency',
    mountpoint     => '/media/tb-tb',
    nbmand         => 'off',
    primarycache   => 'all',
    quota          => '2T',
    readonly       => 'off',
    recordsize     => '128K',
    refquota       => 'none',
    refreservation => 'none',
    reservation    => 'none',
    secondarycache => 'all',
    setuid         => 'on',
    shareiscsi     => '-',
    sharenfs       => 'off',
    sharesmb       => 'off',
    snapdir        => 'hidden',
    version        => '5',
    volsize        => '-',
    vscan          => 'off',
    xattr          => 'on',
    zoned          => 'off',
  }

  zfs { 'dank0/fast':
    ensure         => 'present',
    aclinherit     => 'restricted',
    atime          => 'off',
    canmount       => 'on',
    checksum       => 'off',
    compression    => 'off',
    copies         => '1',
    dedup          => 'off',
    devices        => 'on',
    exec           => 'on',
    logbias        => 'latency',
    mountpoint     => '/dank0/fast',
    nbmand         => 'off',
    primarycache   => 'all',
    quota          => '500G',
    readonly       => 'off',
    recordsize     => '128K',
    refquota       => 'none',
    refreservation => 'none',
    reservation    => 'none',
    secondarycache => 'all',
    setuid         => 'on',
    sharenfs       => 'off',
    sharesmb       => 'off',
    snapdir        => 'hidden',
    version        => '5',
    vscan          => 'off',
    xattr          => 'on',
    zoned          => 'off',
  }

  zfs { 'dank0/docker':
    ensure         => 'present',
    aclinherit     => 'restricted',
    atime          => 'off',
    canmount       => 'on',
    checksum       => 'off',
    compression    => 'off',
    copies         => '1',
    dedup          => 'off',
    devices        => 'on',
    exec           => 'on',
    logbias        => 'latency',
    mountpoint     => '/var/lib/docker-zfs',
    nbmand         => 'off',
    primarycache   => 'all',
    quota          => '1T',
    readonly       => 'off',
    recordsize     => '128K',
    refquota       => 'none',
    refreservation => 'none',
    reservation    => 'none',
    secondarycache => 'all',
    setuid         => 'on',
    sharenfs       => 'off',
    sharesmb       => 'off',
    snapdir        => 'hidden',
    version        => '5',
    vscan          => 'off',
    xattr          => 'on',
    zoned          => 'off',
  }

  zpool { 'dank0':
    ensure => 'present',
    #raidz  => ['wwn-0x50014ee2b9b3bf06 wwn-0x50014ee2645efada wwn-0x50014ee20f13da4b wwn-0x50014ee20efe5b2d cache wwn-0x5e83a97ea01d31ac'],
  }
}
