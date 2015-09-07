define profiles::components::symlinks (
  $filename = $title,
  $base_symlink_path = '/usr/local/bin',
) {
  $puppet_bin_dir = $::clientversion ? {
    /4\.\d+\.\d+/ => '/opt/puppetlabs/puppet/bin',
    default       => '/usr/bin',
  }
  file { "${base_symlink_path}/${filename}":
    ensure => link,
    target => "${puppet_bin_dir}/${filename}"
  }
}
