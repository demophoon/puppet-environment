class profiles::roles::wireguard () {
  apt::ppa { 'ppa:wireguard/wireguard': } ~>
  Exec['apt_update'] ->
  package { ['wireguard', 'wireguard-dkms']: }
}
