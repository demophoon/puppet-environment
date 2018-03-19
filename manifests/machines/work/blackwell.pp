class profiles::machines::work::blackwell () {
  include profiles::roles::development
  include profiles::roles::docker
  include profiles::roles::sudoers
}
