class profiles::machines::linodes::calico {
  require profiles::machines::linode

  include profiles::roles::docker
  include profiles::roles::sudoers
  include profiles::roles::docker::znc
  include profiles::roles::docker::ttrss

  include profiles::roles::nfs::client

  class { 'profiles::roles::backup':
    backup_dirs => [
      '/home/',
      '/opt/',
    ],
  }
}
