node 'RaspberryFro.home.brittg.com' {
  class { 'profiles::base': }
}

node 'linode.brittg.com' {
  class { 'profiles::base': }
  class { 'profiles::webserver': }
}

node default {
  class { 'profiles::base': }
}
