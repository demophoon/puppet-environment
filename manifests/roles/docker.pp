class profiles::roles::docker (
  $options = {},
) {
  class { 'docker':
    storage_driver => 'zfs',
    *              => $options,
  }
  class { 'docker::compose':
    ensure  => present,
    version => '1.18.0',
  }
}
