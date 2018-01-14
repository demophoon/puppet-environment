class profiles::roles::nfs::server () {
  class { '::nfs':
    server_enabled => true,
  }
}
