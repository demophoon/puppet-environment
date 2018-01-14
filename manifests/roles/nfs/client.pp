class profiles::machines::roles::nfs::client () {
  class { '::nfs':
    client_enabled => true,
  }
}
