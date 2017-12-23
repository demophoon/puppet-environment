class profiles::machines::apollo (){
  include docker

  include profiles::roles::development
  include profiles::roles::bolt

  include profiles::roles::apps
  include profiles::roles::yubikey
  include profiles::roles::vagrant

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
    ],
  }
}
