class profiles::roles::i3::lock () {
  package { ['i3lock', 'xautolock', 'scrot', 'imagemagick']:
    ensure => 'present',
  }
}
