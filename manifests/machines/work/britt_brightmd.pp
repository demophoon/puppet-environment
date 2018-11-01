class profiles::machines::work::britt_brightmd (
  $username = 'britt',
) {
  include profiles::roles::apps::slack
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
  package { 'mongodb-org': }

  package { ['magic-wormhole', 'virtualenvwrapper']:
    ensure   => latest,
    provider => 'pip',
  }
}
