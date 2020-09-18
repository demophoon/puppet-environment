class profiles::roles::development (
  $python_version = 'python3',
) {
  class { 'python':
    version    => $python_version,
    pip        => 'present',
    dev        => 'present',
  }
}
