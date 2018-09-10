class profiles::roles::apps::osx () {
  Package {
    ensure   => 'present',
    provider => 'brewcask',
  }

  package { [
    'iterm2',
    'slate',
    'flux',
    'caffeine',
  ]: }
}
