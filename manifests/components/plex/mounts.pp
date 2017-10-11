class profiles::components::plex::mounts {
  mount { '/media/tb-tb':
    ensure   => mounted,
    device   => '/dev/sda1',
    fstype   => 'ext4',
    options  => 'defaults',
    remounts => true,
    atboot   => true,
  }
}
