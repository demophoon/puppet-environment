define profiles::components::webserver::vhost (
  String $service_name = $title,
  $vhosts,
  $port = 80,
  $vhost_options = {},
  $consul_options = {},
  $proxy = "http://127.0.0.1:${port}"
) {
  nginx::resource::server { $vhosts:
    proxy => $proxy,
    *     => $vhost_options,
  }

  #::consul::service { "http-${service_name}":
  #  checks  => [
  #    {
  #      script   => "curl ${proxy}",
  #      interval => '10s'
  #    }
  #  ],
  #  port    => $port,
  #  * => $consul_options,
  #}
}
