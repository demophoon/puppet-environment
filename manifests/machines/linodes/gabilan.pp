class profiles::machines::linodes::gabilan {
  require profiles::machines::linode

  include profiles::roles::docker
  include profiles::roles::sudoers
  #include profiles::roles::docker::znc
  #include profiles::roles::docker::ttrss

  include profiles::roles::nfs::client

  user { 'gitlab':
    groups         => ['sudo', 'www-data'],
    ensure         => present,
    purge_ssh_keys => true,
    managehome     => true,
    home           => "/home/gitlab",
  }
  ssh_authorized_key { 'deploy_key':
    type => 'ssh-ed25519',
    key  => 'AAAAC3NzaC1lZDI1NTE5AAAAICrTWzavCKbr9xEka6qmBu4ulF9lXODcVnsoVyuOifFa',
    user => 'gitlab',
  }
}
