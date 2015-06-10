node 'RaspberryFro.home.brittg.com' {
  class { 'profiles::base': }
}

node 'linode.brittg.com' {
  class { 'profiles::base': }
  class { 'profiles::webserver': }
  class { 'profiles::linode': }
}

node default {
  class { 'profiles::base': }
}
