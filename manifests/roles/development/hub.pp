class profiles::roles::development::hub () {
  include ::snapd
  package { 'hub':
    ensure   => latest,
    provider => 'snap',
  }
}
