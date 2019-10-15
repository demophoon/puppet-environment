class profiles::roles::sudoers () {
  class { 'sudo':
    config_file_replace => false,
  }

  package { 'sudo':
    ensure => latest,
  }

  sudo::conf { 'admins':
    priority => 10,
    content  => '%admin ALL=(ALL) ALL'
  }
  sudo::conf { 'sudoers':
    priority => 11,
    content  => '%sudo ALL=(ALL) ALL'
  }
  sudo::conf { 'root':
    priority => 50,
    content  => 'root ALL=(ALL) ALL'
  }
  sudo::conf { 'britt':
    priority => 100,
    content  => 'britt ALL=(ALL) ALL'
  }
}
