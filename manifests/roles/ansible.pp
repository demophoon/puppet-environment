class profiles::roles::ansible (
  $inventory = {},
) {
  include '::ansible'

  $inventory.each |$group, $nodes| {
    ansible::hosts { $group:
      entrys => $nodes,
    }
  }
}
