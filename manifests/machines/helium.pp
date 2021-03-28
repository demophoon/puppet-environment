class profiles::machines::helium {
  include profiles::roles::development
  include profiles::roles::users::britt
  include profiles::roles::users::alexis
  include profiles::roles::kubectl
}
