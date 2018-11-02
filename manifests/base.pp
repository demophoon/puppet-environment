class profiles::base (
  Hash    $additional_r10k_sources = {},
  String  $hiera_private_key       = '/root/.ssh/id_rsa',
) inherits profiles::params {

  include profiles::roles::masterless

  # We need to make sure we have a key so we at least have a chance at authenticating against the repo
  if enable_private_hiera() {
    class { 'hiera':
      hiera_version  => '5',
      hiera5_defaults => {
        'datadir'   => "${::settings::confdir}/hiera/master/",
        'data_hash' => 'yaml_data',
      },
      hierarchy      => [
        { 'name' => 'Node', 'path' => 'nodes/%{fqdn}.yaml' },
        { 'name' => 'Environment', 'path' => 'environments/%{environment}.yaml' },
        { 'name' => 'Global', 'path' => 'global.yaml' },
      ],
    }
  }

  ## Enable private puppet configs if we have access to them.
  if defined('infra_private') {
    include infra_private
  }

  ## Os Specific Bindings
  case $::osfamily {
    /Debian/: {
      include profiles::roles::linux
    }
    /Darwin/: {
      include profiles::roles::mac
    }
  }
}
