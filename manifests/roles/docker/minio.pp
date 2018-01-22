class profiles::roles::docker::minio () {
  require profiles::roles::docker

  exec {'start_minio':
    command => "/usr/bin/docker run -d -p 9000:9000 -v /media/tb-tb/minio/data:/data -v /media/tb-tb/minio/config:/root/.minio minio/minio server /data",
    unless  => "/usr/bin/docker ps | /bin/grep -q minio",
    path    => '/usr/bin:/bin',
  }
}
