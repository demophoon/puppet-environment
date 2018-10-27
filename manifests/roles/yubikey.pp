class profiles::roles::yubikey () {

  apt::key {
    'yubico launchpad ppa':
      id     => '3653E21064B19D134466702E43D5C49532CBA1A9',
      server => 'pgp.mit.edu',
  }

  apt::ppa { 'ppa:yubico/stable':
    require => Apt::Key['yubico launchpad ppa'],
  }

  package { [
    'gnupg2',
    'gnupg-agent',
    'pinentry-curses',
    'scdaemon',
    'pcscd',
    'yubikey-personalization',
    'libusb-1.0.0-dev',
    'yubioath-desktop',
  ]:
    ensure  => present,
    require => [
      Apt::Ppa['ppa:yubico/stable']
    ],
  }
}
