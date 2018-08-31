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
      $ensure = present
    }
    /Debian/: {
      $install_packages = $_global_packages + $_debian_packages
      $ensure = latest
    }
    default: {
      $install_packages = $_global_packages
      $ensure = latest
    }
  }

  @package { $install_packages:
    ensure => $ensure,
    tag    => ['global'],
  }
}

