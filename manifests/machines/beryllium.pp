class profiles::machines::beryllium (){
  include profiles::roles::ansible
  include profiles::roles::development
  include profiles::roles::docker
  include profiles::roles::zfs
  #include profiles::roles::media::server
  #include profiles::roles::kubectl

  include profiles::roles::users::britt

  class { 'hashicorp::terraform':
    version => '0.12.6',
  }
}
