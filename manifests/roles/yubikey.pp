class profiles::roles::yubikey () {
  package { [
    'gnupg2',
    'gnupg-agent',
    'pinentry-curses',
    'scdaemon',
    'pcscd',
    'yubikey-personalization',
    'libusb-1.0.0-dev',
  ]:
    ensure => present,
  }
}
