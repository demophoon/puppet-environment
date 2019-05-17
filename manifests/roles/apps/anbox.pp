class profiles::roles::apps::anbox () {
  include ::snapd

  apt::ppa { 'ppa:morphis/anbox-support': } ->
  package { ['anbox-modules-dkms']:
    ensure => present,
  } ->
  package { 'anbox':
    ensure   => latest,
    provider => 'snap',
  } ->
  package { ['android-tools-adb']: }

}
