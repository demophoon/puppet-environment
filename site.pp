node /linode.*/ {
  class { 'profiles::linode': }
}

node 'beryllium.home.brittg.com' {
  class { 'profiles::beryllium': }
}

node 'apollo.home.brittg.com' {
  class { 'profiles::apollo': }
}

node default {
  notify {'Node not classified.': }
}

$is_linux = ! ($::macosx or $::windows)

if $is_linux {
  class { 'profiles::base': }
}
