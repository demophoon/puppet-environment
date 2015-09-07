class profiles::components::symlinks {

  $puppet_bin_dir = $::clientversion ? {
    /4\.\d+\.\d+/ => '/opt/puppetlabs/puppet/bin',
    default       => '/usr/bin',
  }

  define profiles::components::symlink (
    $filename = $title,
    $base_symlink_path = '/usr/local/bin',
  ) {
    file { "${base_symlink_path}/${filename}":
      ensure => link,
      target => "${puppet_bin_dir}/${filename}"
    }
  }

  profiles::components::symlink { 'puppet': }
  profiles::components::symlink { 'facter': }
  profiles::components::symlink { 'hiera': }
}
