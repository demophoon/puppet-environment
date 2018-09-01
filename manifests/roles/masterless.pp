# This class contains the basic configuration in order to get puppet running on
# its own in a masterless environment.
class profiles::roles::masterless (
  $hiera_sources     = $profiles::params::default_hiera_sources,
  $r10k_sources      = $profiles::params::default_r10k_sources,
  $control_repo_uri  = $profiles::params::control_repo_uri,
  $run_cron          = { 'minute' => ['0', '30'] },
  $use_r10k_gem      = $profiles::params::use_r10k_gem,
  $r10k_config_group = $profiles::params::r10k_config_group,
) inherits profiles::params {

  # Puppet apply settings
  $puppet_bin_dir = "/opt/puppetlabs/puppet/bin"
  $puppet_code_dir = '/etc/puppetlabs/code'
  $environment_path = "${puppet_code_dir}/environments/${::environment}"
  $module_path = "${environment_path}/modules/"
  $site_pp = "${environment_path}/site.pp"

  # r10k sources setup
  $default_r10k_sources = {
    'puppet' => {
      'remote' => $control_repo_uri,
      'basedir'=> "${puppet_code_dir}/environments",
      'prefix' => false,
    }
  }
  $r10k_source_defaults = deep_merge($default_r10k_sources, $hiera_sources)
  $_r10k_sources = deep_merge($r10k_source_defaults, $r10k_sources)

  if $use_r10k_gem {
    $_r10k_class = 'r10k::config'
    package { 'r10k':
      ensure   => present,
      provider => 'puppet_gem',
    }
  } else {
    $_r10k_class = 'r10k'
  }

  class { $_r10k_class:
    sources    => $_r10k_sources,
    root_group => $r10k_config_group,
    modulepath => "${::settings::confdir}/environments/\$environment/modules:/opt/puppet/share/puppet/modules",
  }
  cron { 'Update r10k and run puppet apply':
    command => "${puppet_bin_dir}/r10k deploy environment -pv && ${puppet_bin_dir}/puppet apply --modulepath ${module_path} --environment ${::environment} ${site_pp}",
    user    => 'root',
    *       => $run_cron,
  }
  service { 'puppet':
    ensure => stopped,
    enable => false,
  }
}
