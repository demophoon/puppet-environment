class profiles::roles::media::clients::nfs (
  $server = undef,
) {
  require profiles::roles::zfs
  require profiles::roles::nfs::server

  nfs::client::mount {'/tank0/media':
    server => $server,
  }
}
