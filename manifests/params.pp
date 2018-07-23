class profiles::params {
  $s3_backup_url = 's3.amazonaws.com'
  $control_repo_uri = 'https://github.com/demophoon/puppet-environment.git'

  if enable_private_hiera() {
    $default_hiera_sources = {
      'hiera' => {
        'remote'       => 'git@github.com:demophoon/hieradata.git',
        'basedir'      => "${::settings::confdir}/hiera",
        'prefix'       => false,
      }
    }
  } else {
    $default_hiera_sources = {}
  }
  $default_r10k_sources = {}
}
