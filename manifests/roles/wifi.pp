class profiles::roles::wifi (
  $connections = {},
) {
  include ::networkmanager

  $connections.each |$name, $options| {
    networkmanager::wifi { $name:
      * => $options,
    }
  }
}
