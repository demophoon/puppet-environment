class profiles::roles::nfs::client () {
  class { '::nfs':
    client_enabled => true,
  }
}
