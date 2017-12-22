class profiles::apollo (){
  include docker
  include vagrant

  include profiles::roles::development
  include profiles::roles::bolt

  include profiles::roles::apps
  include profiles::roles::yubikey

  profiles::roles::backup { $::fqdn:
    backup_dirs => [
      '/home/',
    ],
  }
}
