class profiles::roles::docker (
  $options = {},
) {
  class { 'docker':
    * => $options,
  }
}
