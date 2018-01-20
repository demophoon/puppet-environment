class profiles::machines::linode {
  include profiles::components::users

  class { "profiles::machines::linodes::${::hostname}": }
}
