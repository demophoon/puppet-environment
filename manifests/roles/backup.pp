define profiles::roles::backup (
  $backup_name = $title,
  $backup_dirs = [],
  $bucket = 'backups',
  $s3_url = $::params::s3_backup_url,
) {
  package { 's3cmd':
    ensure => latest,
  }
}
