node 'RaspberryFro.home.brittg.com' {
  class { 'profiles::raspberrypi': }
}

node 'linode.brittg.com' {
  class { 'profiles::linode': }
}

node default {
  class { 'profiles::base': }
}
