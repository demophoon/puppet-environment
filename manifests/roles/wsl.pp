class profiles::roles::wsl () {
  case $::osfamily {
    'Debian': {
      package { [
        'dirmngr',
      ]:
        ensure => present,
      }
    }
  }
}
