class profiles::machines::roles::samba::server () {
  class { '::samba::server':
    workgroup     => 'WORKGROUP',
    server_string => "${::fqdn} Samba Server",
  }
}
