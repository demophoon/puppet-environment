class profiles::components::plex::mounts {
  mount { '/media/Andromeda':
    ensure   => mounted,
    device   => '/dev/sdf1',
    fstype   => 'ext4',
    options  => 'defaults',
    remounts => true,
    atboot   => true,
  }

  file { '/media/tb-tb':
    ensure => link,
    target => '/media/Andromeda/backup/tb-tb/',
   }

  #class { 'samba::server':
  #  workgroup     => 'example',
  #  server_string => "Example Samba Server",
  #  interfaces    => "eth0 lo",
  #  security      => 'share'
  #}

  #samba::server::share { 'beryllium':
  #  path                 => '/media/tb-tb',
  #  guest_only           => true,
  #  guest_ok             => true,
  #  guest_account        => "guest",
  #  browsable            => true,
  #  create_mask          => 0777,
  #  force_create_mask    => 0777,
  #  directory_mask       => 0777,
  #  force_directory_mode => 0777,
  #}
}
