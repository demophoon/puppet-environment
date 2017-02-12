class profiles::components::users {
  # Users
  @user { 'britt':
    ensure         => present,
    password       => '$1$yHFMx/We$PdgVVbs1ifYCWbMuhr1u.0',
    home           => '/home/britt',
    shell          => '/bin/zsh',
    purge_ssh_keys => true,
    managehome     => true,
    tag            => ['global'],
  }

  @user { 'fgresham':
    ensure         => present,
    home           => '/home/fgresham',
    purge_ssh_keys => true,
    managehome     => true,
    tag            => ['tx.dc'],
  }

  # Authorized SSH Keys
  @ssh_authorized_key { 'britt@puppetlabs.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDH0ba8AmBRKhV/ekeiDfTnCNeJ4tItEyG/K6hLDASP1/8H98h7NUxVLyQG+SwSekyHjjSweePTPCLq12tZGzD0FTn2AYgL+fNiYi1uUtZHtcjIxgpvcdGa3sNWsGK00TtxwLA2vUzX7RAvFIYs2OFiHX/Vyn2Rms9Pq/FoMvGpIhS6WkuqNd1K8PDOL/LpLRRVe+j63W5s/vgDXIE3gIZSE6hUvI82M7jze0J+h4X0cSE6RpJXMjnPeXoCy65NhvRrp90omU0aWT1tQUY7fdR4nSFDxtJSOYnPVmLCAscIoGO3iYPTMsBAzBSowQERBCckeJmMJR8XmvaJ4MujiZ7wktVCq4lh19PsfOPP+RzZP9CphddtBaBXCyuDc9gUNF+v1ldP6gG+tIhlA1i0dflOTB6b8yfFLcje0jqUaUbFolkBZB4CZMhRDTEGxybXb7spkVpgltBUKcGELK9lIA1c2Bpdfg6RQeCr6IbJoTSK9z541r6cm7RBTJghvwu340TN+83tW7rh0l5GNh41gQLDlZlyQgj39353V7OmZsygaNU4gJEP8PzlooLgKUv8UQ4QBO77U5huxWUdw5vjWrdKpFjnu0CAqlliecPe0SyKFm6Js1j+MZMaY+/R7ZAY8NGjqlN7/akqsQ1Pku+RBfXfV9Py0BszrQndleAJedoWhw==',
    tag     => ['global'],
    require => User['britt'],
  }

  @ssh_authorized_key { 'britt@nexus7.home.brittg.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDj1CH9EQ+8Ikcjx0hbR8cKh7ihr9fFQCeS1mvX6KqyR1EOHNmzdKdX0XC9eCp7hcj1ryzE6WJ/2buplINOFDm0zjlvauAt2L1gk0KpF5cGQh52hLU65qcqtd5FjkiCS1N1Ka+swWQMHBM8ulxGqwAYyc+HMNL1gExu43KdwR12RdWolUNI9GC54/0+aAlU4uWwyF4b809DDuBJVL8ClYLJUe82K3k9bzewfSxTkUHGIi9Cg+J+HmbeP3ZM7k0YFsIceDTIrVYNRfP8So48FzUYyjwB+TY3J1CX6SLo1GyXNGiJjnq+eMakZA6ICl+rHquZfAViMwRt4Lw6jnBdP1I2uo1ZWMPt9Ekg2IGHopnvcAPKYizn0+QFwv3yCu9TTSSU0I7NQUWbaXUR1FjOvnxuWW0TotM95UdiAY0q7v754cu8cOsgWbmce1zFEhPJiy6VdlyxiIvTPiBjfZdk0rmNiaZLPXB9bGIkuljnsOkteZYvte1o08+Ow0Qd2PU3NN+1CJsNb/HfvJGJMiqIpopusrYzQDgq/QkGWyy/eOG+wJtt8ncQlhq1iE4iVxy3wDJz5AX+aG03P+F49h/GpcRWb9qJBC2kw2avHevC0B3n1DvIjrFhn9pU/uAJa+U0MITeoZPHyOZ6wIvlXldXmtFtzft5uliZ3jJTe1u/ILzgpQ==',
    tag     => ['global'],
    require => User['britt'],
  }
  
  @ssh_authorized_key { 'britt@pixel.home.brittg.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCkxyGGoA9dMoEB+Wdlveo3n+0lmOJ3h7j14jQg/4fINbPIUS9SoaBVVGhDNj+KjeNfAkl4RjgMNN7rgHFUb17CZnBJVx6D90V0bB+4WqJx4290aFH93C0JBYh9z5eY/Efvn2Vl+MxVStbBCtYXEymsRbtGCUe5Vbz5xyQV4dlj3ihG3psdlY7bLwTT5243oQgu2cKvGXPRdU8fZjkYuGWo+sOLtRveMJCZOGb0xRTlUh4TSH0XK9L3Quka5nQTLRGKc0niWbejZtqb8vEfCzbLBwKz973dFxtGNB7Q8lfrHfRt2pEXvCYhf+rjEWiNcF8wi/p3bXxg5n1UrLqGdAdReRDGP3OYBIKKB7AUrA8LHx541U32KekeB2TB7YpJ3B66mlec5jzXOWue5KZOo7S2nXJOO9HdcxRK3dug9/GBjckzJVlmR3WsWXLcYRe5h8mgOA6oZ9GwmSypqQJaSaNbG0MhYhZ2Jq4p4KS2IVF1PHi/x3bl73E9fciHD439IFyQkqVBpmAYiFfEi4iKTPhGSjnJredS9TdKT3tAI/golYzeMnHQM7eXfU4Bbt0DvR50jQkjwOGYK+5EmmEvrEunxoNWVU13WLLqKa1dW9VSX6r7ybbwcQAsfw2nIY1lVGu10S6APxfsd/dc3a/jjmzcAidOZZvrGPpS7PcoS6MW2w==',
    tag     => ['global'],
    require => User['britt'],
  }

  @ssh_authorized_key { 'britt@britt-ubuntu.home.brittg.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCoGprqMrYegwmvsbyENxYThKBOO5Ep8FUnD99Ms244njxdoGp3AbvQZSytL0wkzhcNoQoGe++Z1AWet0NpudwujF0EphZoffWt+0dRBlxeGBfdRydQMngBA6V95NBvugBUyxH9p9ehC/tz6+tKP4iCfPhJAyuBjDKfSiIuZoSRraH+83nlK/Tqgh3KrLlYVRblCl9XxWLIq3UCpoeSl9jQPRXda9u2BUsVu821GfdSFiC2tKpQYSXOJcVZpPI/Zuv2B589FER0ceEuwbOHy/8LHrJEE67tW6W6mb7vBKIp7eTq61ts3jNRMHB3LVBgnS3YzkAA9BlecPvqQlTsHyRH',
    tag     => ['global'],
    require => User['britt'],
  }

  @ssh_authorized_key { 'britt@brittmac.home.brittg.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCmoTyyQBd2Cp9VTy4j1P3gggicvwtu5Z+AOPZ2CaVt68wKyFjGQnRru5VyY23r+WFU1zGWRqvjxL7/q8FV4/vpX6PNbGODzgPir07mnBSHIcCteGwW5mV5dZfyn07Yz6iwhxdnWluOahkIjs4FaN0cnGpdZ1qYk95wL2xAXetJe6x21ZG9ZeDV19096f/NG+HKMl4ZHf9lrAjmNm9CMPmkNjDalbAX9BRJG5p/r4w0tshfpan+B4FwogQ6NuB2MVSjdKArab6nnUT01f4yhjKtLEX4NHMKrv/sRe/4xzjT91h/vor/gUvD5XmmVhuuabRe2JZYLuPmGIqpjfyTDKYRZ1Eo79NmL9NqNHCTULTq0paAk1Vhmip+FC6CMN/z/DHXYnTlxOuJjBDlRmNm1AMVoJeYDD63nUP4AbrpkWXM58xiRsMqIK+wXf7xTQP+r4ll3B35O+sRm2WIRC1U5yagSgecMJjk56fPFf0H3wV48aROio3timQ5coalVz5HeFkWsKy9z1vfv3w0a1rtSu9t4YshArk6cejACNpvKn75Lc87EL3xQehR/QNuxu/jq0McMg7Zn1jFe2tQdcAkiPmAiUBUNJctHOZeQOnN5QOrfUdNnjVwVPRdBjC4+iUXIV7KGcocvva6IKnRXUXEnm9VdU55UW7SHp5CivvMy/6Byw==',
    tag     => ['global'],
    require => User['britt'],
  }

  @ssh_authorized_key { 'britt@windows.home.brittg.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAABJQAAAgEAgyMUGnLbESvI4wf9K7FfDDf+DIno088wgIvAy+SbiEcpW2J7BUeWy8Hn7zIhmMFZq3y9IxVHGXtS3hS1RsYc+ZbA5wvuEiGGUh2xCpUpRYaTkzRMSfEhiXzG0WeLwE1+B5ejFnr679ACm3a1XLDZ11CfjnmIBgMC0po4JrMmy7EyDQh/wLyg08fd9XtLKg4gYX/w3cUU/34Krc5xowqDgDbrjoUv4LFRIESQukIFVjNHODBTlIUcxowFaOOjFlTrdBN4xEpFssQWgw5+4ANOOSR3FXGeCVIKjUPaLwjhdTX+8aGsM9ST1KQ+SDSxlgIHSZpaCw27jK4wsU4qYbYr4JzTNSf2ZDSijB24MO6rJWzmn5F4j3lGdYV4qyIJLSuW0sT0QeVYhUkghaTlF2+epJooZGy0ao7quhDq9sIZy7MfPbphKx5OpKx93JKKchgCIygE6MF1IFeTJuNeE5wVH4yBmF92o3qb45zX8GakEUkiDpAiAA1jlJt8miyqEQoeljqb4SeoSCYR0VN0kPgAtpJoQNO9cWJVbywc94eD2xKqVNzdmQyI8ApiINJDt0fQUmtOdJLLgV30GCZa0hw9yaTfRRng9o4kg0+5FLdBjzQV4lvAo7SwvuYNqBzUA7hdQeCSHh5LKH1VrsJTv2FisstDt0bhRY7K0rntQWet0JM=',
    tag     => ['global'],
    require => User['britt'],
  }

  @ssh_authorized_key { 'jenkins@home.brittg.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDD+Ig8HSjJQyqSCaFk0SQq3h7orFOja6cjG+va1iE/EEFnlGlJ48YoKI8CrRPce/ofZgcCc2b/PlPRp5Kuu4+AMUaJS3SBILq9nKVVyX6KHpukzMkVPi8xKZdkuZhWC19JDDECMDpEggW+EG//m9o4kCLTdxm4vrcAu1wtf3cxOo5qazk36Z5IHChcmXP28DtUzgJwxBKnPt1y9RrRPJ9we0T6MQcI1kL90v5jwAPfCMD9Og4gbarwUVBoNOchwlMU0rwQFBCNlK3961pRtGIKa/SpFcQ9xYEpjxnTMthGwr9VEHV3pGWymRw8nmZOOewSjsXkyCILKOXaIlX8gOMd',
    tag     => ['global'],
    require => User['britt'],
  }

  @ssh_authorized_key { 'nexus6.home.brittg.com':
    user    => 'britt',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC6vKtGbGtYAKR+bJ0UMT65VBJJryK8ES3+Incr2zWtpH25Ur3b03jJfxVVtHbLVRQ/k/tLii+hUh8whykfoNZBFqpQygLmQrJgiGlOFvwVGl0s4ROPZG7Vg4gJg6ng2w6eNOSzgURlUr6yYdaqWPt6OW4pJYqaf50aqqZj1s31rPQ5Aw9IZPU4cgAoCuX1GKTLd2Ww9Zbe/o5eOPVvcESOzai3AZtDG7gC5iL1goDpLSvzI7n/g8UeP9Ei87HHFPnIDCKcMcPl1OEKMgkcfctNBBAhSDhlAeqhXNW4u9P6KN1afQ8XjddFmlCIpiQgkRr4HvFTAD2CL7Acgqc5Bgkoz3iLK8VsttChUZjBupNrs2Mqp1cHNbsSSE0AQvGJGuxF+qiynXpzQ/2/wMfJRoOIwSBSMWDqoVHnerqdQyJnDdmGOz3FkHLlPbcDImGuoRc2ZdZELLpHgELIcvjSeuqo9stjWRt8lysz9hS8zynAXh98Z0uI1i+/vVm7Fj/N9kgWNFTUsf1cQri/Ze9W/kHaDiZN/0NjAtaR9IxO0cDp6XAcRukLNrRtA+GUXim36jGTwvtG7KDS+EEE2Nw78tRSFEyytDX41bOprwwQjcBT5a+zmsSPOBC/B9tD216MQ0+L2oOu3f/jIG6lCHAvZfx8AYeWWoIN2XIO91YbEPQOJQ==',
    tag     => ['global'],
    require => User['britt'],
  }

  @ssh_authorized_key { 'fgresham@Freds-MacBook-Pro.local':
    user    => 'fgresham',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCi9tCkE3ydnxeSthLcEICPhAX91HpX3tdzaYva5SNbzr/OjghCa5QW3FFH0rL9IeHWsu0hXCL9qjtdqtdSNFoPNtjez1buwu78nNCFC+iSqNZIZ0W7z93FMeE7cDWV3VoUBrHv6fWCNdDUeabSdeXJTE004My7GuJhRbCS/LQQkoyg3cGSBdtBcx+nuV5Qek/YFqj7L3pMTaNTCL8//j5fMbJENc7BWDifIoENSLCF4mMYXDitc4TOSP8ycgaekWACxnpCTmgkReXbi987h09tNFpksrvu5jJLeqdr3ZDb3wqlOJLV5FNtRVndh36K6MsuW1q68fwbCkTcIoAA9AW/',
    tag     => ['tx.dc'],
    require => User['fgresham'],
  }

  @ssh_authorized_key { 'agent@agents-MBP-2.home':
    user    => 'fgresham',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC9AW476KW4MqsFE/oJ08rm20IGD5x2BjOgaHo5XsnLrtznvl6VM/SSqshVg7nPwCHAYSlir2gPz6QroFyRoDxhheJ0OSTLW/8sGsjUr1RxdhTHn8oZRVoijn06o9zsNlZfRqIyl8FlJlaJHuU1ySvkInC1iCxR8SDV/1S1nLP6TrnZgfauAYK/zB+T/0s8e6uH6/AHCu0f0an0Lr+S5QN/KdJMiBdNX950T8tq0ZjwxkrPzD/uO1VD6qDB9V7a8L3E2nnYrcxRVb5s7JWRR3iYZoe3IPZZbMT3cWwie2OODaP5m1JruAFE9NGSIavLD/XnQSXSyjmZg9bqW73teo1X',
    tag     => ['tx.dc'],
    require => User['fgresham'],
  }
}
