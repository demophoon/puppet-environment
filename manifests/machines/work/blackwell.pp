class profiles::machines::work::blackwell (
  $nfs_clients = 'localhost(rw)',
) {
  include profiles::roles::development
  include profiles::roles::development::ruby
  include profiles::roles::docker
  include profiles::roles::sudoers

  include profiles::roles::nfs::server

  nfs::server::export {'/home/britt/projects':
    ensure  => present,
    clients => $nfs_clients,
  }
}
