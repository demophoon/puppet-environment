class profiles::roles::vagrant () {
  include vagrant

  apt::key { 'oracle':
    id     => 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF',
    server => 'pgp.mit.edu',
    notify => Exec['apt_update'],
   } ->
  package { 'virtualbox-5.2':
    ensure => present,
  }
}

