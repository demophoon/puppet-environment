class profiles::components::symlinks {

  $puppet_bin_dir = $::clientversion ? {
    /4\.\d+\.\d+/ => '/opt/puppetlabs/puppet/bin',
    default       => '/usr/bin',
  }

  define profiles::components::symlink (
    $filename,
    $base_symlink_path="/usr/local/bin",
  ) {
    file { "${base_symlink_path}/${filename}"
      ensure => link,
      target => "${puppet_bin_dir}/${filename}"
    }
  }

  profiles::components::symlink {
    filename =>'puppet'
  }
  profiles::components::symlink {
    filename =>'facter'
  }
  profiles::components::symlink {
    filename =>'hiera'
  }
}
