class profiles::roles::certbot () {
  class { '::letsencrypt':
    email          => 'ca-letsencrypt@brittg.com',
    manage_install => true,
  }
}
