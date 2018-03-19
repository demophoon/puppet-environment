node 'oso.demophoon.com', 'calico.demophoon.com'  {
  class { 'profiles::machines::linode': }
}

node 'beryllium.home.brittg.com' {
  class { 'profiles::machines::beryllium': }
}

node 'apollo.home.brittg.com' {
  class { 'profiles::machines::apollo': }
}

node default {
  if defined("profiles::machines::${::fqdn}") {
    class { "profiles::machines::${::fqdn}": }
  } elsif defined("profiles::machines::work::${::fqdn}") {
    class { "profiles::machines::work::${::fqdn}": }
  } else {
    notify {'Node not classified.': }
  }
}

$is_linux = ! ($::macosx or $::windows)

if $is_linux {
  class { 'profiles::base': }
}
