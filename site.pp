class { 'profiles::base': }

node 'RaspberryFro.home.brittg.com' {
  class { 'profiles::raspberrypi': }
}

node 'linode.brittg.com' {
  class { 'profiles::linode': }
}

node 'britt-ubuntu' {
  class { 'profiles::britt_ubuntu': }
}

node default { }
