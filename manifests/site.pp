node /.*\.home\.brittg\.com/ {
  class { 'profiles::base': }
}

node 'linode.brittg.com' {
  class { 'profiles::base': }
}

node default {
  class { 'profiles::base': }
}
