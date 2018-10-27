class profiles::roles::apps::light () {
  package { 'autoconf': }
  vcsrepo { '/opt/light':
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/haikarainen/light',
    require  => Package['autoconf'],
  } ~>
  exec { 'autogen light':
    command     => 'autogen.sh',
    path        => '/bin:/usr/bin:/usr/local/bin:/opt/light',
    cwd         => '/opt/light',
    refreshonly => true,
  } ~>
  exec { 'configure light':
    command     => 'configure',
    path        => '/bin:/usr/bin:/usr/local/bin:/opt/light',
    cwd         => '/opt/light',
    refreshonly => true,
  } ~>
  exec { 'make light':
    command     => 'make',
    path        => '/bin:/usr/bin:/usr/local/bin:/opt/light',
    cwd         => '/opt/light',
    refreshonly => true,
  } ~>
  exec { 'install light':
    command     => 'make install',
    path        => '/bin:/usr/bin:/usr/local/bin:/opt/light',
    cwd         => '/opt/light',
    refreshonly => true,
  }
}
