class profiles::machines::work::arcadia (
  $username = 'britt',
) {
  include profiles::roles::apps
  include profiles::roles::apps::slack
  include profiles::roles::apps::osx
  #include infra_private::roles::aorta

  Package {
    ensure   => present,
    provider => 'homebrew',
  }

  Exec {
    path        => '/bin:/usr/bin:/usr/local/bin',
    user        => $username,
    environment => ["HOME=/Users/${username}"],
    refreshonly => true,
  }

  File {
    owner => $username,
    group => 'wheel',
  }

 package { 'nvim': } ->
 package { 'neovim':
   ensure   => latest,
   provider => 'pip',
 } ->
 package { 'neovim':
   ensure   => latest,
   provider => 'pip3',
 }

  package { [
    'awscli',
    'vagrant',
    'virtualbox',
  ]: }

  file { '/private/etc/letsencrypt':
    ensure => directory,
  }

  package { 'gettext': } ~>
  exec { 'brew link gettext --force': }

  package { 'mongodb@3.4': } ~>
  exec { [
    'launchctl load /usr/local/Cellar/mongodb*/3.*/homebrew.mxcl.mongodb*.plist',
    'brew services start $(brew services list|awk \'/^mongodb/ {print $1}\')',
  ]: }

  package { ['magic-wormhole', 'virtualenvwrapper']:
    ensure   => latest,
    provider => 'pip',
  }
}
