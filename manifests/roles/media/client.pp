class profiles::roles::media::client (
  $server = undef,
  $mount_type = 'nfs',
) {
  class { "profiles::roles::media::clients::${mount_type}":
    server => $server,
  }
}
