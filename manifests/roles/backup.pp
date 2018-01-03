class profiles::roles::backup (
  String           $backup_name   = $::fqdn,
  Array[String]    $backup_dirs   = [],
  String           $bucket        = 'backups',
  String           $s3_url        = $::profiles::params::s3_backup_url,
  Optional[String] $s3_access_key = undef,
  Optional[String] $s3_secret_key = undef,
) inherits profiles::params {
  package { 's3cmd':
    ensure => latest,
  }

  if ! ($s3_access_key and $s3_secret_key) {
    notice("Backups are not properly configured for ${::fqdn}. Add S3 credentials to enable backups.")
  } else {
    notice("Backups properly enabled!")
    $base_s3_url = "s3://${bucket}/${backup_name}"

    file { '/root/.s3cfg':
      ensure  => file,
      content => template('profiles/s3cfg.erb'),
    }

    $backup_dirs.each |$i, $dir| {
      $s3_url = "${base_s3_url}${dir}"

      cron { "S3 backup ${s3_url}":
        command => "s3cmd sync -F '${dir}' '${s3_url}'",
        user    => 'root',
        minute  => 0,
        hour    => $i,
      }
    }

  }
}
