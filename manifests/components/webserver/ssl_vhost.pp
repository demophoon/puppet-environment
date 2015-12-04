define profiles::components::webserver::ssl_vhost (
  String $www_root,
  String $vhost_name = $title,
  String $letsencrypt_ssl_root = '/etc/letsencrypt/live/',
  Boolean $rewrite_to_https = true,
) {
  nginx::resource::vhost { "${vhost_name}":
    www_root         => "${www_root}",
    ssl              => true,
    ssl_cert         => "/etc/letsencrypt/live/${vhost_name}/cert.pem",
    ssl_key          => "/etc/letsencrypt/live/${vhost_name}/privkey.pem",
    rewrite_to_https => $rewrite_to_https,
  }
}
