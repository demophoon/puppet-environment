class profiles::roles::media::clients::nfs (
  $server = undef,
) {
  require profiles::roles::nfs::client

  nfs::client::mount {'/tank0/media':
    server => $server,
  }

  nfs::client::mount {'/media/tb-tb':
    server => $server,
  }
}
