class { 'profiles::base': }

node 'RaspberryFro.home.brittg.com' {
  class { 'profiles::raspberrypi': }
}

node /linode.*/ {
  class { 'profiles::linode': }
}

node 'britt-ubuntu' {
  class { 'profiles::britt_ubuntu': }
}

node default { }
