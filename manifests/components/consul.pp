class profiles::components::consul(
  $datacenter,
){
  class { '::consul':
    config_hash => {
      'bootstrap_expect' => 1,
      'client_addr'      => '127.0.0.1',
      'data_dir'         => '/opt/consul',
      'datacenter'       => $datacenter,
      'log_level'        => 'INFO',
      'node_name'        => $::fqdn,
      'server'           => true,
      'ui_dir'           => '/opt/consul/ui',
    }
  }
}
