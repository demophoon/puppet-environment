class profiles::machines::work::britt_brightmd_vagrant (
  $username = 'britt',
) {
  include profiles::roles::development

  include profiles::roles::docker

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
 ]: }

  file { '/etc/letsencrypt':
    ensure => directory,
  }

  package { 'gettext': }
}
