class profiles::machines::apollo (){
  include docker

  include profiles::roles::development
  include profiles::roles::bolt

  include profiles::roles::apps
  include profiles::roles::yubikey
  include profiles::roles::vagrant

  profiles::roles::backup { $::fqdn:
    backup_dirs => [
      '/home/',
    ],
  }
}
