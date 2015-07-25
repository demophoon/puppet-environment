class profiles::components::users {
  # Users
  @user { 'britt':
    ensure         => present,
    home           => '/home/britt',
    shell          => '/bin/zsh',
    purge_ssh_keys => true,
    tag            => ['global'],
  }

  @user { 'fgresham':
    ensure         => present,
    home           => '/home/fgresham',
    purge_ssh_keys => true,
    tag            => ['linode'],
  }

  # Authorized SSH Keys
  @ssh_authorized_key { 'britt@puppetlabs.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDH0ba8AmBRKhV/ekeiDfTnCNeJ4tItEyG/K6hLDASP1/8H98h7NUxVLyQG+SwSekyHjjSweePTPCLq12tZGzD0FTn2AYgL+fNiYi1uUtZHtcjIxgpvcdGa3sNWsGK00TtxwLA2vUzX7RAvFIYs2OFiHX/Vyn2Rms9Pq/FoMvGpIhS6WkuqNd1K8PDOL/LpLRRVe+j63W5s/vgDXIE3gIZSE6hUvI82M7jze0J+h4X0cSE6RpJXMjnPeXoCy65NhvRrp90omU0aWT1tQUY7fdR4nSFDxtJSOYnPVmLCAscIoGO3iYPTMsBAzBSowQERBCckeJmMJR8XmvaJ4MujiZ7wktVCq4lh19PsfOPP+RzZP9CphddtBaBXCyuDc9gUNF+v1ldP6gG+tIhlA1i0dflOTB6b8yfFLcje0jqUaUbFolkBZB4CZMhRDTEGxybXb7spkVpgltBUKcGELK9lIA1c2Bpdfg6RQeCr6IbJoTSK9z541r6cm7RBTJghvwu340TN+83tW7rh0l5GNh41gQLDlZlyQgj39353V7OmZsygaNU4gJEP8PzlooLgKUv8UQ4QBO77U5huxWUdw5vjWrdKpFjnu0CAqlliecPe0SyKFm6Js1j+MZMaY+/R7ZAY8NGjqlN7/akqsQ1Pku+RBfXfV9Py0BszrQndleAJedoWhw==',
    tag  => ['global'],
  }

  @ssh_authorized_key { 'britt@chromebook.home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDqHI7MvhcCW/D+TP5cnTDIMpxFjRbx8aAABd5SMPIG+WU46HDKCb9PRtz5vYwiw/P9sdY0KyzHQikq7/p3zNcSDXv1dKFm68obj3SsQVrfrXCqBzi/1Kt1bLrP0rWyKgYYSg0v3Y0Dvcu9WXXWMKzHkofN7Dh4j6QQbKvjsyrro3C1eLZNjUuoqEP6S8dAeJduXEIrVcb2weoTYDZT4s2NQxueh4UMtiSux4dqxCOG8mL1adtzrCk1yiV74zUrC5vv4hJfEP5uiVItzm8OS3hHOfcVzO8lKtXSDTVki3mcBHxZFZhOQaLajZFYSrJOcRaT6fgJR/ZCKyhYsoL5jDiQ4PWe4jj4HC8rMsr4senE5ejrkJgAMvBf38L+ihdcbJ6tMQqYMV3enVMIOtGWpgqPGlRwYD0T4TaUSDBx7vXKWDKuaeNB0ce8RCD+HxvJZO+NwZ72YZ7n5KKlF9bzxV25S6rvUSuOueUC/Q0NXcJOSvJTwmL+nXmalfbuFMPlnVYaCUBj6oaJTCsGzeJnt388i2cc6/bO0B8f+JD71ArUPJ/f//tkHgZ9MX9GB36S/z4RHY01HB1k5j6k1DzE1lQmYwu6Rz6WTdb9HHU89ca7J4ohG1hmJbb4WwearzES11fvbr+/ZVt7krCmDONoJqgJAOvOHbfZOLUPuzhsGSd0oQ==',
    tag  => ['global'],
  }

  @ssh_authorized_key { 'britt@britt-ubuntu.home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCoGprqMrYegwmvsbyENxYThKBOO5Ep8FUnD99Ms244njxdoGp3AbvQZSytL0wkzhcNoQoGe++Z1AWet0NpudwujF0EphZoffWt+0dRBlxeGBfdRydQMngBA6V95NBvugBUyxH9p9ehC/tz6+tKP4iCfPhJAyuBjDKfSiIuZoSRraH+83nlK/Tqgh3KrLlYVRblCl9XxWLIq3UCpoeSl9jQPRXda9u2BUsVu821GfdSFiC2tKpQYSXOJcVZpPI/Zuv2B589FER0ceEuwbOHy/8LHrJEE67tW6W6mb7vBKIp7eTq61ts3jNRMHB3LVBgnS3YzkAA9BlecPvqQlTsHyRH',
    tag  => ['global'],
  }

  @ssh_authorized_key { 'britt@brittmac.home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCmoTyyQBd2Cp9VTy4j1P3gggicvwtu5Z+AOPZ2CaVt68wKyFjGQnRru5VyY23r+WFU1zGWRqvjxL7/q8FV4/vpX6PNbGODzgPir07mnBSHIcCteGwW5mV5dZfyn07Yz6iwhxdnWluOahkIjs4FaN0cnGpdZ1qYk95wL2xAXetJe6x21ZG9ZeDV19096f/NG+HKMl4ZHf9lrAjmNm9CMPmkNjDalbAX9BRJG5p/r4w0tshfpan+B4FwogQ6NuB2MVSjdKArab6nnUT01f4yhjKtLEX4NHMKrv/sRe/4xzjT91h/vor/gUvD5XmmVhuuabRe2JZYLuPmGIqpjfyTDKYRZ1Eo79NmL9NqNHCTULTq0paAk1Vhmip+FC6CMN/z/DHXYnTlxOuJjBDlRmNm1AMVoJeYDD63nUP4AbrpkWXM58xiRsMqIK+wXf7xTQP+r4ll3B35O+sRm2WIRC1U5yagSgecMJjk56fPFf0H3wV48aROio3timQ5coalVz5HeFkWsKy9z1vfv3w0a1rtSu9t4YshArk6cejACNpvKn75Lc87EL3xQehR/QNuxu/jq0McMg7Zn1jFe2tQdcAkiPmAiUBUNJctHOZeQOnN5QOrfUdNnjVwVPRdBjC4+iUXIV7KGcocvva6IKnRXUXEnm9VdU55UW7SHp5CivvMy/6Byw==',
    tag  => ['global'],
  }

  @ssh_authorized_key { 'britt@windows.home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAABJQAAAgEAgyMUGnLbESvI4wf9K7FfDDf+DIno088wgIvAy+SbiEcpW2J7BUeWy8Hn7zIhmMFZq3y9IxVHGXtS3hS1RsYc+ZbA5wvuEiGGUh2xCpUpRYaTkzRMSfEhiXzG0WeLwE1+B5ejFnr679ACm3a1XLDZ11CfjnmIBgMC0po4JrMmy7EyDQh/wLyg08fd9XtLKg4gYX/w3cUU/34Krc5xowqDgDbrjoUv4LFRIESQukIFVjNHODBTlIUcxowFaOOjFlTrdBN4xEpFssQWgw5+4ANOOSR3FXGeCVIKjUPaLwjhdTX+8aGsM9ST1KQ+SDSxlgIHSZpaCw27jK4wsU4qYbYr4JzTNSf2ZDSijB24MO6rJWzmn5F4j3lGdYV4qyIJLSuW0sT0QeVYhUkghaTlF2+epJooZGy0ao7quhDq9sIZy7MfPbphKx5OpKx93JKKchgCIygE6MF1IFeTJuNeE5wVH4yBmF92o3qb45zX8GakEUkiDpAiAA1jlJt8miyqEQoeljqb4SeoSCYR0VN0kPgAtpJoQNO9cWJVbywc94eD2xKqVNzdmQyI8ApiINJDt0fQUmtOdJLLgV30GCZa0hw9yaTfRRng9o4kg0+5FLdBjzQV4lvAo7SwvuYNqBzUA7hdQeCSHh5LKH1VrsJTv2FisstDt0bhRY7K0rntQWet0JM=',
    tag  => ['global'],
  }

  @ssh_authorized_key { 'jenkins@home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDD+Ig8HSjJQyqSCaFk0SQq3h7orFOja6cjG+va1iE/EEFnlGlJ48YoKI8CrRPce/ofZgcCc2b/PlPRp5Kuu4+AMUaJS3SBILq9nKVVyX6KHpukzMkVPi8xKZdkuZhWC19JDDECMDpEggW+EG//m9o4kCLTdxm4vrcAu1wtf3cxOo5qazk36Z5IHChcmXP28DtUzgJwxBKnPt1y9RrRPJ9we0T6MQcI1kL90v5jwAPfCMD9Og4gbarwUVBoNOchwlMU0rwQFBCNlK3961pRtGIKa/SpFcQ9xYEpjxnTMthGwr9VEHV3pGWymRw8nmZOOewSjsXkyCILKOXaIlX8gOMd',
    tag  => ['global'],
  }

  @ssh_authorized_key { 'nexus6.home.brittg.com':
    user => 'britt',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC6vKtGbGtYAKR+bJ0UMT65VBJJryK8ES3+Incr2zWtpH25Ur3b03jJfxVVtHbLVRQ/k/tLii+hUh8whykfoNZBFqpQygLmQrJgiGlOFvwVGl0s4ROPZG7Vg4gJg6ng2w6eNOSzgURlUr6yYdaqWPt6OW4pJYqaf50aqqZj1s31rPQ5Aw9IZPU4cgAoCuX1GKTLd2Ww9Zbe/o5eOPVvcESOzai3AZtDG7gC5iL1goDpLSvzI7n/g8UeP9Ei87HHFPnIDCKcMcPl1OEKMgkcfctNBBAhSDhlAeqhXNW4u9P6KN1afQ8XjddFmlCIpiQgkRr4HvFTAD2CL7Acgqc5Bgkoz3iLK8VsttChUZjBupNrs2Mqp1cHNbsSSE0AQvGJGuxF+qiynXpzQ/2/wMfJRoOIwSBSMWDqoVHnerqdQyJnDdmGOz3FkHLlPbcDImGuoRc2ZdZELLpHgELIcvjSeuqo9stjWRt8lysz9hS8zynAXh98Z0uI1i+/vVm7Fj/N9kgWNFTUsf1cQri/Ze9W/kHaDiZN/0NjAtaR9IxO0cDp6XAcRukLNrRtA+GUXim36jGTwvtG7KDS+EEE2Nw78tRSFEyytDX41bOprwwQjcBT5a+zmsSPOBC/B9tD216MQ0+L2oOu3f/jIG6lCHAvZfx8AYeWWoIN2XIO91YbEPQOJQ==',
    tag => ['global'],
  }

  @ssh_authorized_key { 'fgresham@Freds-MacBook-Pro.local':
    user => 'fgresham',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCi9tCkE3ydnxeSthLcEICPhAX91HpX3tdzaYva5SNbzr/OjghCa5QW3FFH0rL9IeHWsu0hXCL9qjtdqtdSNFoPNtjez1buwu78nNCFC+iSqNZIZ0W7z93FMeE7cDWV3VoUBrHv6fWCNdDUeabSdeXJTE004My7GuJhRbCS/LQQkoyg3cGSBdtBcx+nuV5Qek/YFqj7L3pMTaNTCL8//j5fMbJENc7BWDifIoENSLCF4mMYXDitc4TOSP8ycgaekWACxnpCTmgkReXbi987h09tNFpksrvu5jJLeqdr3ZDb3wqlOJLV5FNtRVndh36K6MsuW1q68fwbCkTcIoAA9AW/',
    tag  => ['linode'],
  }
}
