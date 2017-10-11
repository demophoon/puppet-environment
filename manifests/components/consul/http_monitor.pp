define profiles::components::consul::http_monitor (
  String $uri = $title,
  Optional[String] $monitor_name = $uri,
  String $interval = '30s',
) {

  ::consul::check { $uri:
    interval => $interval,
    script   => "curl ${uri} >/dev/null 2>&1",
  }
}
