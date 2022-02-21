node 'oso.demophoon.com', 'calico.demophoon.com'  {
  class { 'profiles::machines::linode': }
}

node 'beryllium.cascadia.demophoon.com' {
  class { 'profiles::machines::beryllium': }
}

node 'apollo.home.brittg.com' {
  class { 'profiles::machines::apollo': }
}

node default {
  $classification_hostname = regsubst($::hostname, '-', '_', 'G')
  if defined("profiles::machines::${classification_hostname}") {
    class { "profiles::machines::${classification_hostname}": }
  } elsif defined("profiles::machines::work::${classification_hostname}") {
    class { "profiles::machines::work::${classification_hostname}": }
  } else {
    notify {"Node '${classification_hostname}' is not classified.": }
    class { "profiles::machines::no_classification": }
  }
}

class { 'profiles::base': }
