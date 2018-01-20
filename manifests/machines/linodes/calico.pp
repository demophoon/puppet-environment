class profiles::machines::linodes::calico {
  require profiles::machines::linode

  include profiles::roles::docker
}
