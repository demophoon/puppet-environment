class profiles::components::jenkins (
  String $username,
  String $password,
){
  class { 'jenkins':
    install_java      => true,
    cli_remoting_free => true,
    cli_username      => $username,
    cli_password      => $password,
  }
}
