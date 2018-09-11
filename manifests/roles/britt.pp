class profiles::roles::britt (
  String  $username  = 'britt',
  Boolean $developer = false,
  Hash    $additional_user_params = {},
){

  case $::osfamily {
    'Darwin': {
      Ssh_authorized_key {
        user    => $username,
      }
      class { 'dotfiles':
        homedir => "/Users/${username}",
      }
    }
    default: {
      Ssh_authorized_key {
        user    => $username,
        require => User[$username],
      }
      user { $username:
        ensure         => present,
        password       => '$1$yHFMx/We$PdgVVbs1ifYCWbMuhr1u.0',
        home           => "/home/${username}",
        shell          => '/bin/zsh',
        purge_ssh_keys => true,
        managehome     => true,
        *              => $additional_user_params,
      } ->
      class { 'dotfiles': }
    }
  }

  if $developer {
    $github_token = lookup('github_token', Optional[String], 'first', undef)
    if $github_token != undef {
      $additional_params = {
        github_token => $github_token,
      }
    } else {
      $additional_params = {}
    }

    profiles::components::developer { $username:
      github_username => 'demophoon',
      require         => Class['dotfiles'],
      *               => $additional_params,
    }
  }

  ssh_authorized_key { 'yubikey':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC4fK7PotURVlARzUgFtahep86v5IbCShG0NTBgLfGw4g7IC/SSpEiU1vyj8RsGYcUhq9DKOqvObQWpplOz7eiuigFNMyv+dOYs8I/3wbwXQirvTalM0eC+aYCwiza3CQBri+EjwOafRdMDYdvT7rXPaktHEsOcGmkhBVH90znp2/2WOgPFwJfrAf3edZULB2PZS4p31lmJd72EZ/mnb8zW9tSGPmyXsKPsa2kWDlRClCe0lGtlhzHGCizwlqolKvL/GeM+qyT3IQ3OAUDRB9iBIVyzgQXK3XHB1BHZeKLxtpsP1iUA1zUJLLNch0QsKWsdWaAbVyQptdetW2kUCwSiCF3CtOgdFSLX+Qq3AXpyWxQ+FltAiOhiZCVWSs7y+mCgHhwpA6QiOONQ+xcZgmmg9D4Q8YYNi4tzSq/w2SCFKShk7Oc+JKO6uLH/GItoltc3VDdXOQ29hY9TCXFPTsIMMHSvrHDtpIkdtfyK8VFsnRl2S9ZBSUnPP54R/A8T+KZscSfu6dCc5ffqDLngMHG9mct2ZE50DKHYzqrBihvEukktOl+onZvuUdN5b7EgG/wZgEu0ZoYH59H1CBR5sgvNDeZ+0oRTCIQPx3KJCTAgZGpHOPQsQLE8zpCqNCtDpeB4SUoSU3UqLY9hh/air9TrrNUM/RrjfB4lbC80AGEt7Q==',
  }

  ssh_authorized_key { 'britt@nexus7.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDj1CH9EQ+8Ikcjx0hbR8cKh7ihr9fFQCeS1mvX6KqyR1EOHNmzdKdX0XC9eCp7hcj1ryzE6WJ/2buplINOFDm0zjlvauAt2L1gk0KpF5cGQh52hLU65qcqtd5FjkiCS1N1Ka+swWQMHBM8ulxGqwAYyc+HMNL1gExu43KdwR12RdWolUNI9GC54/0+aAlU4uWwyF4b809DDuBJVL8ClYLJUe82K3k9bzewfSxTkUHGIi9Cg+J+HmbeP3ZM7k0YFsIceDTIrVYNRfP8So48FzUYyjwB+TY3J1CX6SLo1GyXNGiJjnq+eMakZA6ICl+rHquZfAViMwRt4Lw6jnBdP1I2uo1ZWMPt9Ekg2IGHopnvcAPKYizn0+QFwv3yCu9TTSSU0I7NQUWbaXUR1FjOvnxuWW0TotM95UdiAY0q7v754cu8cOsgWbmce1zFEhPJiy6VdlyxiIvTPiBjfZdk0rmNiaZLPXB9bGIkuljnsOkteZYvte1o08+Ow0Qd2PU3NN+1CJsNb/HfvJGJMiqIpopusrYzQDgq/QkGWyy/eOG+wJtt8ncQlhq1iE4iVxy3wDJz5AX+aG03P+F49h/GpcRWb9qJBC2kw2avHevC0B3n1DvIjrFhn9pU/uAJa+U0MITeoZPHyOZ6wIvlXldXmtFtzft5uliZ3jJTe1u/ILzgpQ==',
  }

  ssh_authorized_key { 'britt@beryllium.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC2sPkn4YjcnTjfPEqUTjvokbUetaXDTGY+YlgvPNOymdJSv0OcTD62IKBZSiW70exXwPmcB0fAoehrKMFL0hog3P9v8Y26+64BUL0v4ansckkyMo+SKSaTcrmXpKuGocyD3tevzOJBT1XrVqHsCqBo2ukWhFR/XNrfVu/t9dGPYdEoHI4rDv+ZcHkTVrLZtJliPo9RkmUxRo0+NMFYpYwkaeUi6Gq35++HXZBNnHbPhB9rZE+yujF80XQzvIUk1pOWphSL1ODm2jyTSD+L1+xliX9Upp18PwK1ESz3nQg0MiCpEdvWSWXncxlnmSzEmLrho1/MWdVsuAoltcFH8vatWK0tYd6gLDCjBEP2pE5v7/WA5yjd7lJwRh9spufXbFogq54huZtVm02t244t5kKKHmDKK/nD7GTU2jlpfKu0tSF8GRJ06h24LZmRJ06mk7kO77hxbf7W8xyNT+MO0pTNfRwo4v0vgmxnqSgqRgUpYNkGhlxrhgemj1ouZr3KooD4PrHSqBUML45FA/1tkm6k/6+mEtgExP2LnbmVSboVkJZhkLqrTBsHoUgoolqweCPvR7WQw3ovYWZN8zUqGtZuSk8mm0m26DG2BOOI+OfR8qRWzOdbybUCPVpgqJatwDtpeVsRaowKkJiT8a15Vx0KR9D0HBmnSmF/ZGMwyGIh8Q==',
  }

  ssh_authorized_key { 'britt@brittmac.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCmoTyyQBd2Cp9VTy4j1P3gggicvwtu5Z+AOPZ2CaVt68wKyFjGQnRru5VyY23r+WFU1zGWRqvjxL7/q8FV4/vpX6PNbGODzgPir07mnBSHIcCteGwW5mV5dZfyn07Yz6iwhxdnWluOahkIjs4FaN0cnGpdZ1qYk95wL2xAXetJe6x21ZG9ZeDV19096f/NG+HKMl4ZHf9lrAjmNm9CMPmkNjDalbAX9BRJG5p/r4w0tshfpan+B4FwogQ6NuB2MVSjdKArab6nnUT01f4yhjKtLEX4NHMKrv/sRe/4xzjT91h/vor/gUvD5XmmVhuuabRe2JZYLuPmGIqpjfyTDKYRZ1Eo79NmL9NqNHCTULTq0paAk1Vhmip+FC6CMN/z/DHXYnTlxOuJjBDlRmNm1AMVoJeYDD63nUP4AbrpkWXM58xiRsMqIK+wXf7xTQP+r4ll3B35O+sRm2WIRC1U5yagSgecMJjk56fPFf0H3wV48aROio3timQ5coalVz5HeFkWsKy9z1vfv3w0a1rtSu9t4YshArk6cejACNpvKn75Lc87EL3xQehR/QNuxu/jq0McMg7Zn1jFe2tQdcAkiPmAiUBUNJctHOZeQOnN5QOrfUdNnjVwVPRdBjC4+iUXIV7KGcocvva6IKnRXUXEnm9VdU55UW7SHp5CivvMy/6Byw==',
  }

  ssh_authorized_key { 'britt@windows.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAABJQAAAgEAgyMUGnLbESvI4wf9K7FfDDf+DIno088wgIvAy+SbiEcpW2J7BUeWy8Hn7zIhmMFZq3y9IxVHGXtS3hS1RsYc+ZbA5wvuEiGGUh2xCpUpRYaTkzRMSfEhiXzG0WeLwE1+B5ejFnr679ACm3a1XLDZ11CfjnmIBgMC0po4JrMmy7EyDQh/wLyg08fd9XtLKg4gYX/w3cUU/34Krc5xowqDgDbrjoUv4LFRIESQukIFVjNHODBTlIUcxowFaOOjFlTrdBN4xEpFssQWgw5+4ANOOSR3FXGeCVIKjUPaLwjhdTX+8aGsM9ST1KQ+SDSxlgIHSZpaCw27jK4wsU4qYbYr4JzTNSf2ZDSijB24MO6rJWzmn5F4j3lGdYV4qyIJLSuW0sT0QeVYhUkghaTlF2+epJooZGy0ao7quhDq9sIZy7MfPbphKx5OpKx93JKKchgCIygE6MF1IFeTJuNeE5wVH4yBmF92o3qb45zX8GakEUkiDpAiAA1jlJt8miyqEQoeljqb4SeoSCYR0VN0kPgAtpJoQNO9cWJVbywc94eD2xKqVNzdmQyI8ApiINJDt0fQUmtOdJLLgV30GCZa0hw9yaTfRRng9o4kg0+5FLdBjzQV4lvAo7SwvuYNqBzUA7hdQeCSHh5LKH1VrsJTv2FisstDt0bhRY7K0rntQWet0JM=',
  }

  ssh_authorized_key { 'britt@bash-windows.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCzLJnHBl714lgLqJqbEheeDW2T5EEQ4rIicEDGThagRHgwMOCbvSBV3y7lSF/wYx+N45ZtXiW6+/I3OC00fYsx2dYCnb2rEiWyGxLVNn7B/NtJWRzqEtbQADHff4dR/cEKE2S529WP715Ip5UIhwI457knxOzRTWdxagpXe1uUQh13LXrgHhQOVS85kgIOh9Ksfyg0Qc865mVJppIIXmClBAreYM9R0tJHi2T2OQmSaZjgUuRHD+TIPb/Psjmp2eKy+TVJCOZ08nj4LREu14msN1Max/AlxFP6aT8FYXKPcE1D3yIMTCaBxVEKjm9oVDAFXf7OGdgMDgFisn6QeE0fMJL/4qzMFNWcQ9OJ5HBKa6HrOrx79TXcolKoLbAv8N3NlsFQdor40gRa9sxJ5C/GydoxNWbk1JUpY6vVMGIiuICmZgRPdTevrS/fiUFxdrG7NeCW7JeSPg2P7Zbfw+wmGh+npFiscWFvkYmGZaYDBe0qMILU1GTcQGDB+6gYuX1CBxRWKzX24Inox/qH7g/6LeL1o4T+d5pKJB414MA+0dvw/WLxV28y89t6+PO8iPqIUqLsRrJn0r/uqXitG7vn58MBBhrfH+8dBGqoTxE5fxdITwO375m5D2YSSoMX4Wg9AC4Q9ULFWTp+fYiz3XHwtQQ+4qOJaZYOk/fyu7ry/w==',
  }

  ssh_authorized_key { 'ubuntu@apollo.home.brittg.com':
    type    => 'ssh-ed25519',
    key     => 'AAAAC3NzaC1lZDI1NTE5AAAAIAnOAYhlyJnwV6Nau90q8G5eNzZBkZm/WGCG9/jRSgKj',
  }

  ssh_authorized_key { 'windows@apollo.home.brittg.com':
    type    => 'ssh-ed25519',
    key     => 'AAAAC3NzaC1lZDI1NTE5AAAAIEZ/I9JVorm2QwBo01rPPNrCl6OPwWOqEShqVvpFDwtI',
  }

  ssh_authorized_key { 'pixel2.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDpMfiwj/eLftCBooWJ6jIU0f+587hynQAZ/+7D7j6yd4afpgBohcAeKMSP0AqecCjU3KJN4QTgsyBWorKD06c0iV92qF+oQzvwR+eddogHWiqbvEyoWi7cRkIZRkdmZN2FtcpLct5uHSsfMMbRINbmF6Ol55w6HKTPNDy8hxFhHg30DzBh7MKBXW1B4S74IbCD3SrLlHzdZg1xYBEtKyh0xbQnO2TuhmlXxHAGTIkIZv3oUX8v2uFOs1uYqftOeQCLGe2QtYDLL50bBkAlFYwafZTCj7r9BCKveyb+Mas5bUA9YKXVk5JsqaGH87uIfj5Vtm8ynvDn+kxGu5PNsQFvJpH5QQGMaHN5iqozB4cDkjYMhHdo1ejLFnpHFC0ies/OTGirrfnl4T788P1b84pwy7KWHWyDZZT+sVfxsNg/Ona2gouvfzsbM3i8W+zxRLuOLNFY83LGwKnX21pAF1F8k14eGKo0aMR/Y0DzVH1x8tWZKfmelyq278LbugLiFcEhW+E4h9FFm8GbQikOmh/CMOzT2zTLe3mowlvhnyL85vPLi6Gkgz2wcs8SJoRoWbcNhM1lpvssT4CSIb5rMAndDtaeRntY+YERwnllZ/4cbJCJdmWfIV4B8mZwOIOcwS95JSVIZp2whTc2cqQrv+QvuJDced0kk5L9y6IJQTrlkw==',
  }

  ssh_authorized_key { 'unicorn':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDiXF1d2CLD4tdE1bIhbaE7eH+K+Z1iHGqg2iMj7SNObqTLjxtELL7gnRv8vAU/K2eFfR572n+HIWxOzRvpNUz8zXDA094PaZKJoVFx5AKCXVXOd5wRf64ygn3YbCTJfegdrThOg3xxwngy+NHz+ETyOG4Qx0c7ciIkbrVou/7DUsEM2nqcdAZ+mnZs415/uwkGvLNWp5tSOMdsqMeVgIqD0FxJwQcQCv2JZn9sGK03FWn5RHs7xC3veupnzTT1985EKry3V8cNJH0zowr3XgkHG+BeFcsaqgimlzq4WUrJ2e4OopsB7kxpv5N928w1BmRAVqLZ6iNHePOmDEDiwMN7',
  }

  ssh_authorized_key { 'britt-bright.md@arcadia.work.demophoon.com':
    type    => 'ssh-ed25519',
    key     => 'AAAAC3NzaC1lZDI1NTE5AAAAIM362UM9A8B9YBBikcZ1WWX/NIkk7HKmsSbXAfx7qm/B',
  }

}
