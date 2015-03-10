class profiles::base {
  $latest_packages = [
    'vim',
    'zsh',
    'bash',
    'ntp',
  ]

  package { $latest_packages:
    ensure => latest,
  }

  user { 'britt':
    ensure         => present,
    home           => '/home/britt',
    shell          => '/bin/zsh',
    purge_ssh_keys => true,
  }

  ssh_authorized_key { 'britt@puppetlabs.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDH0ba8AmBRKhV/ekeiDfTnCNeJ4tItEyG/K6hLDASP1/8H98h7NUxVLyQG+SwSekyHjjSweePTPCLq12tZGzD0FTn2AYgL+fNiYi1uUtZHtcjIxgpvcdGa3sNWsGK00TtxwLA2vUzX7RAvFIYs2OFiHX/Vyn2Rms9Pq/FoMvGpIhS6WkuqNd1K8PDOL/LpLRRVe+j63W5s/vgDXIE3gIZSE6hUvI82M7jze0J+h4X0cSE6RpJXMjnPeXoCy65NhvRrp90omU0aWT1tQUY7fdR4nSFDxtJSOYnPVmLCAscIoGO3iYPTMsBAzBSowQERBCckeJmMJR8XmvaJ4MujiZ7wktVCq4lh19PsfOPP+RzZP9CphddtBaBXCyuDc9gUNF+v1ldP6gG+tIhlA1i0dflOTB6b8yfFLcje0jqUaUbFolkBZB4CZMhRDTEGxybXb7spkVpgltBUKcGELK9lIA1c2Bpdfg6RQeCr6IbJoTSK9z541r6cm7RBTJghvwu340TN+83tW7rh0l5GNh41gQLDlZlyQgj39353V7OmZsygaNU4gJEP8PzlooLgKUv8UQ4QBO77U5huxWUdw5vjWrdKpFjnu0CAqlliecPe0SyKFm6Js1j+MZMaY+/R7ZAY8NGjqlN7/akqsQ1Pku+RBfXfV9Py0BszrQndleAJedoWhw==',
  }

  ssh_authorized_key { 'britt@chromebook.home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDA1jWsyzwKBzWDer8nnYFg+tjfR2y8UM3l9Q33wDuEvVtsmSK8wJN63MjTCr9K+kCziYn6JT8JOx4L36v1XXmETEg0d9nxayAFEwiQa4NiBRL84sv2aY/mUBq3lPqyE5GiRTUbW131qkEdYT9DM7L/aDpKSZz9fFqElzXL/TD8sgMfnKHu004QblKl/oCovVPYFSYXsYa03r9MnS3FNRCt+1Q56JEBJcTXeB3GfmEVTQY0/V/n3/hoVdUHYTnuWNKGbyFw7LX/Brqplx9FBCmwYrtmqhXx6AMNOgXhwitxHWGRO/aIcC4AnP1C/NEL5AByBIuYmkOcerH6OARvslYJ',
  }

  ssh_authorized_key { 'britt@britt-ubuntu.home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCoGprqMrYegwmvsbyENxYThKBOO5Ep8FUnD99Ms244njxdoGp3AbvQZSytL0wkzhcNoQoGe++Z1AWet0NpudwujF0EphZoffWt+0dRBlxeGBfdRydQMngBA6V95NBvugBUyxH9p9ehC/tz6+tKP4iCfPhJAyuBjDKfSiIuZoSRraH+83nlK/Tqgh3KrLlYVRblCl9XxWLIq3UCpoeSl9jQPRXda9u2BUsVu821GfdSFiC2tKpQYSXOJcVZpPI/Zuv2B589FER0ceEuwbOHy/8LHrJEE67tW6W6mb7vBKIp7eTq61ts3jNRMHB3LVBgnS3YzkAA9BlecPvqQlTsHyRH',
  }

  class { 'r10k':
    remote => 'https://github.com/demophoon/puppet-environment.git',
  }

  $apply_environment = 'production'
  $apply_path = "/etc/puppet/environments/${apply_environment}"
  $apply_module_path = "${apply_path}/modules/"
  $site_pp = "${apply_path}/site.pp"

  cron { 'puppet apply':
    command => "/usr/bin/puppet apply --modulepath ${apply_module_path} ${site_pp}",
    user    => 'root',
    minute  => ['0', '30'],
  }

  cron { 'r10k update environments':
    command => '/usr/local/bin/r10k deploy environment -pv',
    user    => 'root',
    minute  => ['15', '45'],
  }
}
