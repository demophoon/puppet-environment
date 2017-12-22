class profiles::roles::vagrant () {
  include vagrant

  apt::key { 'oracle-vbox-2016':
    id     => 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF',
    server => 'pgp.mit.edu',
   } ->
  apt::key { 'oracle-vbox':
    id     => '7B0FAB3A13B907435925D9C954422A4B98AB5139',
    server => 'pgp.mit.edu',
   } ->
   apt::source { 'oracle-virtualbox':
     location => 'http://download.virtualbox.org/virtualbox/debian',
     repos    => "contrib",
   } -> Exec['apt_update'] ->
  package { 'virtualbox-5.2':
    ensure  => present,
  }
}

