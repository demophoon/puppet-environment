class profiles::apollo (){
  include docker

  include profiles::roles::development
  include profiles::roles::bolt

  include profiles::roles::apps

  profiles::roles::backup { $::fqdn:
    backup_dirs => [
      '/home/',
    ],
  }
}
