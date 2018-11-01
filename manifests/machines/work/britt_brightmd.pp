class profiles::machines::work::britt_brightmd (
  $username = 'britt',
) {
  include profiles::roles::development
  include profiles::roles::wifi
  include profiles::roles::nextcloud_client

  include profiles::roles::apps
  include profiles::roles::apps::light
  include profiles::roles::i3
  include profiles::roles::linux::thinkpad
  include profiles::roles::docker

  #include infra_private::roles::aorta

  Exec {
    path        => '/bin:/usr/bin:/usr/local/bin',
    user        => $username,
    environment => ["HOME=/home/${username}"],
    refreshonly => true,
  }

  File {
    owner => $username,
    group => $username,
  }

 package { 'neovim': }

 package { [
    'awscli',
    'vagrant',
    'virtualbox',
 ]: }

  file { '/etc/letsencrypt':
    ensure => directory,
  }

  package { 'gettext': }
}
