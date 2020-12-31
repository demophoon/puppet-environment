class profiles::roles::users::britt (
  String  $username  = 'britt',
  String  $password  = '',
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
        password       => $password,
        home           => "/home/${username}",
        shell          => '/bin/zsh',
        purge_ssh_keys => true,
        managehome     => true,
        *              => $additional_user_params,
      } ->
      class { 'dotfiles': }
      package { [
          'cmake',
          'vim-nox',
          'mono-complete',
          'golang',
          'nodejs',
          'default-jdk',
          'npm',
        ]:
        ensure => present,
      }
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
      require => Class['dotfiles'],
      *       => $additional_params,
    }
  }

  ssh_authorized_key { 'yk5':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDUXBV+G5DPbpqMici/SOA6SiH0fV4buXEysz5fdunByIcpdH1yrCCeIzUnGAq6nXinQmV4LiApR9o98RMAEtm/G4lSLcK/zDk3a5NGPDsii+DsoATyLy6407rAErhg+ZZrLW8P9eS8yDGDDSmb1L1b6C0L+SyCjKi509xcYW7M5uiedO0iYNFPCwzb+6JQVz03D7Xa3hg5dSEPQE2C7Nfh7LiXxbcd+q05MvtqoSw9zbn5SFh6k3ykrup3qZD1mxTCtF8XBss6kyn7Um0cfNOVWsQZFs6hR91ODMfH8CkR0HWngmmX86YkQkrEJ6rDAwIOIyjacByLdNgldCe9i0yNIFGV6VO+TWbmWju8sjh2oR2VbFjTSWOi8nkRET7c4ExTRWH+mY3wCIG2AIZ+ugfV6HotpbjUHgyUmHhFjBNmzNkJrEGmg7MZ3uAYWONHsw+O/+CuSknwFCXq+1EJXqQoct9gqLZ4XWcy0pJGtGAtgjpXqp0rTXGmYxwLV7m0E07kq0zypmBv7NGyY43O9siETAPd5WusoF4mUP+oVSahzBdy4qd2bClZf+oEvJ2zBewCaESYMsvQ6wbmsDVUpOx+rvi+K39bBEpcD1KkCy2FKzXyUqrUszQTEMqhynRWtP5XVyEjbo1+WLYcFYFePYC9G0meL7S52l7aSzZx2iHxGw==',
  }

  ssh_authorized_key { 'yubikey':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC4fK7PotURVlARzUgFtahep86v5IbCShG0NTBgLfGw4g7IC/SSpEiU1vyj8RsGYcUhq9DKOqvObQWpplOz7eiuigFNMyv+dOYs8I/3wbwXQirvTalM0eC+aYCwiza3CQBri+EjwOafRdMDYdvT7rXPaktHEsOcGmkhBVH90znp2/2WOgPFwJfrAf3edZULB2PZS4p31lmJd72EZ/mnb8zW9tSGPmyXsKPsa2kWDlRClCe0lGtlhzHGCizwlqolKvL/GeM+qyT3IQ3OAUDRB9iBIVyzgQXK3XHB1BHZeKLxtpsP1iUA1zUJLLNch0QsKWsdWaAbVyQptdetW2kUCwSiCF3CtOgdFSLX+Qq3AXpyWxQ+FltAiOhiZCVWSs7y+mCgHhwpA6QiOONQ+xcZgmmg9D4Q8YYNi4tzSq/w2SCFKShk7Oc+JKO6uLH/GItoltc3VDdXOQ29hY9TCXFPTsIMMHSvrHDtpIkdtfyK8VFsnRl2S9ZBSUnPP54R/A8T+KZscSfu6dCc5ffqDLngMHG9mct2ZE50DKHYzqrBihvEukktOl+onZvuUdN5b7EgG/wZgEu0ZoYH59H1CBR5sgvNDeZ+0oRTCIQPx3KJCTAgZGpHOPQsQLE8zpCqNCtDpeB4SUoSU3UqLY9hh/air9TrrNUM/RrjfB4lbC80AGEt7Q==',
  }

  ssh_authorized_key { 'britt@beryllium.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC2sPkn4YjcnTjfPEqUTjvokbUetaXDTGY+YlgvPNOymdJSv0OcTD62IKBZSiW70exXwPmcB0fAoehrKMFL0hog3P9v8Y26+64BUL0v4ansckkyMo+SKSaTcrmXpKuGocyD3tevzOJBT1XrVqHsCqBo2ukWhFR/XNrfVu/t9dGPYdEoHI4rDv+ZcHkTVrLZtJliPo9RkmUxRo0+NMFYpYwkaeUi6Gq35++HXZBNnHbPhB9rZE+yujF80XQzvIUk1pOWphSL1ODm2jyTSD+L1+xliX9Upp18PwK1ESz3nQg0MiCpEdvWSWXncxlnmSzEmLrho1/MWdVsuAoltcFH8vatWK0tYd6gLDCjBEP2pE5v7/WA5yjd7lJwRh9spufXbFogq54huZtVm02t244t5kKKHmDKK/nD7GTU2jlpfKu0tSF8GRJ06h24LZmRJ06mk7kO77hxbf7W8xyNT+MO0pTNfRwo4v0vgmxnqSgqRgUpYNkGhlxrhgemj1ouZr3KooD4PrHSqBUML45FA/1tkm6k/6+mEtgExP2LnbmVSboVkJZhkLqrTBsHoUgoolqweCPvR7WQw3ovYWZN8zUqGtZuSk8mm0m26DG2BOOI+OfR8qRWzOdbybUCPVpgqJatwDtpeVsRaowKkJiT8a15Vx0KR9D0HBmnSmF/ZGMwyGIh8Q==',
  }

  ssh_authorized_key { 'britt@windows.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAABJQAAAgEAgyMUGnLbESvI4wf9K7FfDDf+DIno088wgIvAy+SbiEcpW2J7BUeWy8Hn7zIhmMFZq3y9IxVHGXtS3hS1RsYc+ZbA5wvuEiGGUh2xCpUpRYaTkzRMSfEhiXzG0WeLwE1+B5ejFnr679ACm3a1XLDZ11CfjnmIBgMC0po4JrMmy7EyDQh/wLyg08fd9XtLKg4gYX/w3cUU/34Krc5xowqDgDbrjoUv4LFRIESQukIFVjNHODBTlIUcxowFaOOjFlTrdBN4xEpFssQWgw5+4ANOOSR3FXGeCVIKjUPaLwjhdTX+8aGsM9ST1KQ+SDSxlgIHSZpaCw27jK4wsU4qYbYr4JzTNSf2ZDSijB24MO6rJWzmn5F4j3lGdYV4qyIJLSuW0sT0QeVYhUkghaTlF2+epJooZGy0ao7quhDq9sIZy7MfPbphKx5OpKx93JKKchgCIygE6MF1IFeTJuNeE5wVH4yBmF92o3qb45zX8GakEUkiDpAiAA1jlJt8miyqEQoeljqb4SeoSCYR0VN0kPgAtpJoQNO9cWJVbywc94eD2xKqVNzdmQyI8ApiINJDt0fQUmtOdJLLgV30GCZa0hw9yaTfRRng9o4kg0+5FLdBjzQV4lvAo7SwvuYNqBzUA7hdQeCSHh5LKH1VrsJTv2FisstDt0bhRY7K0rntQWet0JM=',
  }

  ssh_authorized_key { 'britt@bash-windows.home.brittg.com':
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCzLJnHBl714lgLqJqbEheeDW2T5EEQ4rIicEDGThagRHgwMOCbvSBV3y7lSF/wYx+N45ZtXiW6+/I3OC00fYsx2dYCnb2rEiWyGxLVNn7B/NtJWRzqEtbQADHff4dR/cEKE2S529WP715Ip5UIhwI457knxOzRTWdxagpXe1uUQh13LXrgHhQOVS85kgIOh9Ksfyg0Qc865mVJppIIXmClBAreYM9R0tJHi2T2OQmSaZjgUuRHD+TIPb/Psjmp2eKy+TVJCOZ08nj4LREu14msN1Max/AlxFP6aT8FYXKPcE1D3yIMTCaBxVEKjm9oVDAFXf7OGdgMDgFisn6QeE0fMJL/4qzMFNWcQ9OJ5HBKa6HrOrx79TXcolKoLbAv8N3NlsFQdor40gRa9sxJ5C/GydoxNWbk1JUpY6vVMGIiuICmZgRPdTevrS/fiUFxdrG7NeCW7JeSPg2P7Zbfw+wmGh+npFiscWFvkYmGZaYDBe0qMILU1GTcQGDB+6gYuX1CBxRWKzX24Inox/qH7g/6LeL1o4T+d5pKJB414MA+0dvw/WLxV28y89t6+PO8iPqIUqLsRrJn0r/uqXitG7vn58MBBhrfH+8dBGqoTxE5fxdITwO375m5D2YSSoMX4Wg9AC4Q9ULFWTp+fYiz3XHwtQQ+4qOJaZYOk/fyu7ry/w==',
  }

  ssh_authorized_key { 'windows@apollo.home.brittg.com':
    type    => 'ssh-ed25519',
    key     => 'AAAAC3NzaC1lZDI1NTE5AAAAIEZ/I9JVorm2QwBo01rPPNrCl6OPwWOqEShqVvpFDwtI',
  }

  ssh_authorized_key { 'pixel2.home.brittg.com':
    type    => 'ecdsa-sha2-nistp384',
    key     => 'AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBH65LmMCCo+LyPLwwJdJWDfHW15fwn44NKhj6kJgkg3KJCXZQVeqFyS/wPRxg+fNRnabCGatpgldBnvWcPK2+a+hjomUvBn3KHUGvpYbqtLmrBy6JtXn+wRiWLiX9u3LVA==',
  }

  ssh_authorized_key { 'unicorn':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDiXF1d2CLD4tdE1bIhbaE7eH+K+Z1iHGqg2iMj7SNObqTLjxtELL7gnRv8vAU/K2eFfR572n+HIWxOzRvpNUz8zXDA094PaZKJoVFx5AKCXVXOd5wRf64ygn3YbCTJfegdrThOg3xxwngy+NHz+ETyOG4Qx0c7ciIkbrVou/7DUsEM2nqcdAZ+mnZs415/uwkGvLNWp5tSOMdsqMeVgIqD0FxJwQcQCv2JZn9sGK03FWn5RHs7xC3veupnzTT1985EKry3V8cNJH0zowr3XgkHG+BeFcsaqgimlzq4WUrJ2e4OopsB7kxpv5N928w1BmRAVqLZ6iNHePOmDEDiwMN7',
  }

  ssh_authorized_key { 'apollo':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC7SytXOwYRjpLj2L7f5PvEtQmyguv5JxHIxcIP/MeL0sKW490ZsB+ztcCOKMCut81lhYRpcMsGT5iBXEyqU167e9aclT9+gxklSp+Fu1mPXj/k0iJf0OGbvX56mo3Wur7cO6tYkU4w+483gpq7AM/3hj85y+sZhPxmRMvlowQFRaFrzeqJCTR+PvuLsVc8e1WKQ4dVmg3LXssNBqrXEbYbZZdSDjRGXNfzg+cukFB/5Jggg+De4VWgtPa7TdDfQxVD5b+UR8AIZfiE6MU8hU8fdBfoBGIbNsw5/NiEaXXyRPiEj1V1Ba07o0IUr7NkdLk6DeGgzRiB+hGPae8hR0cR',
  }

  ssh_authorized_key { 'ipad':
    type => 'ssh-ed25519',
    key  => 'AAAAC3NzaC1lZDI1NTE5AAAAIOzna72FKTMoJxlSyyuaR4qHoooN7I78Q+ZCCH2Ol3pb',
  }
  
  ssh_authorized_key { 'trinity':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAyjpBVjViT1hnIO8UonYA3TGmkBHfqyuE8arGbeH1TSPLGX9PB7FhPKNlN/wAhSruyMLLy8wjzTrsqbelSrrid2f/HZdAm+kRk3bH7q8cPR03bApbWNvO80/gt6ld+yE55ynPU9qOjqa2f3lPWtBpVfZURVrS550vPFdTLWwHxQj/OEnKRopdMNu/wmgR9x5dEzKDew1N8VHL7MCNZzP63gMJBvKUp69q6+DPudrQZa+K765xbQsD1ojj1XTMNWIbtIjvGsaQCus0J44c1rCVBtyTI8skoEie9BiOg6dbJsro23Nu4LeyJ0p8ivR9JldOgrEeV9RLjBDvkHYjOa7kdQ==',
  }

  ssh_authorized_key { 'beryllium':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCohDO0Nu4vYkW3k/nv8eLPRXiIbEjfKvaShiSAdGh3os7amTyVuAHoMB8MUKrOAM1Rko6YCcafUJgua7OJHL3RchS9qIBl18uXaE9ZVKlQO3iD1F1pUlUDuI6x0VhaCvCadWa2UHiilZ4xeG2cjCNBwafhrSMqM0DUIMRJMCuwXYAEnEUIMHLaHabTJcJOhwb9ysW6q6NiBlVAhw6MToKk6btZyRtseh7L1bSv1S4E8ChX4ITVCXwuddXk4mni2Gs9EGfbsY8mkIqXBjD2x2pkFtVq3qakbZZVokNXvbvksL6yRn+pTkl1K2BqyNGH2DWOt6S7nZ6MN93qiNZZsZBxvCJlAZoM4PF8wP0ScP50qqxEnLK53coSpNewhteLc4QlOlIpZZxmAHpxhpGe48ggA+41NhaGAhrJktFM/h9n0brjHCOhmEF5DDphPo7h6o0BVKd2yEHY2eC0eDBhCEZCWlQR0GRn8GV2W6y2gLBjFM3TWvKyMPdhCWo1soS7UxvC+KS8bMHdybwn+azmcvqtrft6HuMXR5L0wAJaYre3Gc+xFuz93O8SNespxve3fp2YKE/VIClrIew3dRNruvbgN65LVHhQpJe6afE9jqrFGDKMUV6PTp/B4u1cnN+8ZM08FaRxVYQ+3NbG5vHKitetbSEVA5z0HCvZXYV8xa/9gw==',
  }

  ssh_authorized_key { 'helios':
    type => 'ssh-ed25519',
    key  => 'AAAAC3NzaC1lZDI1NTE5AAAAIJ6z4PxtPlUS4aOvY8/XBJDCUr0juwIKVXrClcJkI6QH',
  }
}
