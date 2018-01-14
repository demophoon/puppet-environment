class profiles::machines::apollo (){
  include profiles::roles::development
  include profiles::roles::bolt

  include profiles::roles::apps
  include profiles::roles::yubikey
  include profiles::roles::vagrant
  include profiles::roles::i3
  include profiles::roles::docker
  include profiles::roles::nfs::client
  include profiles::roles::media::client

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
    ],
  }
}
