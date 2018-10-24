class profiles::roles::i3 () {
  include profiles::roles::i3::lock

  package { 'i3':
    ensure => 'present',
  }

  package { 'py3status':
    ensure   => 'present',
    provider => 'pip3',
  }
}
