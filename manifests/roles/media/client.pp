class profiles::roles::media::client (
  $server = undef,
  $mount_type = 'nfs',
) {
  if $mount_type == 'nfs' {
    nfs::client::mount {'/tank0/media':
      server => $server,
    }
  }
}
