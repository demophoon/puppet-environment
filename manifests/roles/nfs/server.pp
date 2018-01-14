class profiles::machines::roles::nfs::server () {
  class { '::nfs':
    server_enabled => true,
  }
}
