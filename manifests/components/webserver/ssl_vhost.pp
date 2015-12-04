define profiles::components::webserver::ssl_vhost (
  String $www_root,
  String $vhost_name = $title,
  String $letsencrypt_ssl_root = '/etc/letsencrypt/live',
  Boolean $rewrite_to_https = true,
  Boolean $use_full_chain = true,
) {
  if $use_full_chain {
    $_certname = 'fullchain.pem'
  } else {
    $_certname = 'cert.pem'
  }

  nginx::resource::vhost { "${vhost_name}":
    www_root         => "${www_root}",
    ssl              => true,
    ssl_cert         => "${letsencrypt_ssl_root}/${vhost_name}/${_certname}",
    ssl_key          => "${letsencrypt_ssl_root}/${vhost_name}/privkey.pem",
    rewrite_to_https => $rewrite_to_https,
  }
}
