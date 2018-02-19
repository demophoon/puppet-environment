class profiles::roles::media::server (
  $password = 'example',
) {

  require profiles::roles::zfs
  require profiles::roles::nfs::server
  require profiles::roles::samba::server

  zfs { 'dank0/media':
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
    mountpoint     => '/tank0/media',
    nbmand         => 'off',
    primarycache   => 'all',
    quota          => '6T',
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
    zoned          =>  'off',
  }

  samba::server::user { 'britt':
    password => $password,
  }

  samba::server::share {'media':
    path        => '/tank0/media',
    read_only   => false,
    guest_ok    => true,
    valid_users => 'britt',
  }

  nfs::server::export {'/tank0/media':
    ensure  => present,
    nfstag  => 'media',
    clients => '192.168.1.0/24(rw,insecure,async,no_root_squash) localhost(rw)',
  }

}
