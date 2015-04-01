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
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDqHI7MvhcCW/D+TP5cnTDIMpxFjRbx8aAABd5SMPIG+WU46HDKCb9PRtz5vYwiw/P9sdY0KyzHQikq7/p3zNcSDXv1dKFm68obj3SsQVrfrXCqBzi/1Kt1bLrP0rWyKgYYSg0v3Y0Dvcu9WXXWMKzHkofN7Dh4j6QQbKvjsyrro3C1eLZNjUuoqEP6S8dAeJduXEIrVcb2weoTYDZT4s2NQxueh4UMtiSux4dqxCOG8mL1adtzrCk1yiV74zUrC5vv4hJfEP5uiVItzm8OS3hHOfcVzO8lKtXSDTVki3mcBHxZFZhOQaLajZFYSrJOcRaT6fgJR/ZCKyhYsoL5jDiQ4PWe4jj4HC8rMsr4senE5ejrkJgAMvBf38L+ihdcbJ6tMQqYMV3enVMIOtGWpgqPGlRwYD0T4TaUSDBx7vXKWDKuaeNB0ce8RCD+HxvJZO+NwZ72YZ7n5KKlF9bzxV25S6rvUSuOueUC/Q0NXcJOSvJTwmL+nXmalfbuFMPlnVYaCUBj6oaJTCsGzeJnt388i2cc6/bO0B8f+JD71ArUPJ/f//tkHgZ9MX9GB36S/z4RHY01HB1k5j6k1DzE1lQmYwu6Rz6WTdb9HHU89ca7J4ohG1hmJbb4WwearzES11fvbr+/ZVt7krCmDONoJqgJAOvOHbfZOLUPuzhsGSd0oQ==',
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
