class profiles::roles::development::hub () {
  if $::facts['os']['name'] == 'Ubuntu' {
    include ::snapd
    package { 'hub':
      ensure   => latest,
      provider => 'snap',
    }
  }
}
