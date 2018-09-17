class profiles::roles::apps::osx () {
  Package {
    ensure   => 'present',
    provider => 'brewcask',
  }

  package { 'homebrew/cask-drivers':
    ensure   => present,
    provider => 'tap',
  }

  package { [
    'iterm2',
    'slate',
    'flux',
    'caffeine',
    'gpg-suite',
    'yubico-authenticator',
    'emacs',
  ]: }
}
