define profiles::components::symlinks (
  $filename = $title,
  $base_symlink_path = '/usr/local/bin',
) {
  $puppet_bin_dir = "${::settings::confdir}"

  file { "${base_symlink_path}/${filename}":
    ensure => link,
    target => "${puppet_bin_dir}/${filename}"
  }
}
