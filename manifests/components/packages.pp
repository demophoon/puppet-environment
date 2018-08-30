class profiles::components::packages {
  $_debian_packages = [
    'bash',
    'ntp',
    'p7zip',
    'unzip',
    'curl',
    'htop',
    'silversearcher-ag',
    'fail2ban',
  ]

  $_osx_packages = [
    'gnu-tar',
    'the_silver_searcher',
  ]

  $_global_packages = [
    'zsh',
    'vim',
    'tmux',
    'mercurial',
    'tree',
    'wget',
  ]

  case $::osfamily {
    /Darwin/: {
      $install_packages = $_global_packages + $_osx_packages
    }
    /Debian/: {
      $install_packages = $_global_packages + $_debian_packages
    }
    default: {
      $install_packages = $_global_packages
    }
  }

  @package { $install_packages:
    ensure => latest,
    tag    => ['global'],
  }
}

