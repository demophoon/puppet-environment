class profiles::roles::development (
  $python_version = 'python36',
) {
  class { 'python':
    version    => $python_version,
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present',
  }
}
