class profiles::base () inherits profiles::params {
  case $::osfamily {
    /Debian/: {
      include profiles::roles::linux
    }
    /Darwin/: {}
  }
}
