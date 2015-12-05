define profiles::components::webserver::ssl_vhost (
  String $www_root,
  Optional[String] $proxy      = undef,
  String $vhost_name           = $title,
  String $letsencrypt_ssl_root = '/etc/letsencrypt/live',
  Boolean $rewrite_to_https    = true,
  Boolean $use_full_chain      = true,
) {
  if $use_full_chain {
    $_certname = 'fullchain.pem'
  } else {
    $_certname = 'cert.pem'
  }

  if !$www_root and !$proxy {
    fail('www_root or proxy must be passed into ssl_vhost defined type')
  }

  letsencrypt_client::cert { "${vhost_name}":
    webroot => $www_root,
  }

  if $proxy {
    $_www_root = undef
  } else {
    $_www_root = $www_root
  }

  nginx::resource::vhost { "${vhost_name}":
    www_root         => $_www_root,
    proxy            => $proxy,
    ssl              => true,
    ssl_cert         => "${letsencrypt_ssl_root}/${vhost_name}/${_certname}",
    ssl_key          => "${letsencrypt_ssl_root}/${vhost_name}/privkey.pem",
    rewrite_to_https => $rewrite_to_https,
    require          => Letsencrypt_client::Cert["${vhost_name}"],
  }
}
