class profiles::roles::mariadb () {
  include apt

  apt::source { 'mariadb':
    location => 'http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      id     => '177F4010FE56CA3336300305F1656F24C74CD1D8',
      server => 'hkp://keyserver.ubuntu.com:80',
    },
    include => {
      src   => false,
      deb   => true,
    },
  }

  class {'::mysql::server':
    package_name     => 'mariadb-server',
    package_ensure   => 'latest',
    service_name     => 'mysql',
    root_password    => 'AVeryStrongPasswordUShouldEncrypt!',
    override_options => {
      mysqld => {
        'log-error' => '/var/log/mysql/mariadb.log',
        'pid-file'  => '/var/run/mysqld/mysqld.pid',
      },
      mysqld_safe => {
        'log-error' => '/var/log/mysql/mariadb.log',
      },
    }
  }

  # Dependency management. Only use that part if you are installing the repository
  # as shown in the Preliminary step of this example.
  Apt::Source['mariadb'] ~>
  Class['apt::update'] ->
  Class['::mysql::server']
}
