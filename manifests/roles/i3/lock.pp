class profiles::roles::i3::lock () {
  package { ['i3lock', 'scrot', 'imagemagick']:
    ensure => 'present',
  }
}
