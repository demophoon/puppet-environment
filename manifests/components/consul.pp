class profiles::components::consul(
  $datacenter,
  $server = false,
  $pool = undef,
){
  if $server {
    class { '::consul':
      config_hash => {
        'bootstrap_expect' => 1,
        'client_addr'      => '0.0.0.0',
        'data_dir'         => '/opt/consul',
        'datacenter'       => $datacenter,
        'log_level'        => 'INFO',
        'node_name'        => $::fqdn,
        'server'           => true,
        'ui_dir'           => '/opt/consul/ui',
      }
    }
  } else {
    class { '::consul':
      config_hash => {
        'data_dir'         => '/opt/consul',
        'datacenter'       => $datacenter,
        'log_level'        => 'INFO',
        'node_name'        => $::fqdn,
        'retry_join'       => $pool,
      }
    }
  }
}
