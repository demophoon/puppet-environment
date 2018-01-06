class profiles::roles::i3 () {
  include profiles::roles::i3::lock

  package { 'i3':
    ensure => 'present',
  }
}
