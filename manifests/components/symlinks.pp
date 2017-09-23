define profiles::components::symlinks (
  $filename = $title,
  $base_symlink_path = '/usr/local/bin',
  $bin_dir = "/opt/puppetlabs/puppet/bin"
) {

  file { "${base_symlink_path}/${filename}":
    ensure => link,
    target => "${bin_dir}/${filename}"
  }
}
