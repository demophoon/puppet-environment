class profiles::roles::seedbox () {
  class { 'transmission':
    rpc_username => 'britt',
    rpc_password => 'password',
    rpc_port     => 8080,
    peer_port    => 54612,
    encryption   => 2,
  }
}
