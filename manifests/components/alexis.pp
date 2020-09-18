class profiles::components::alexis {
  # Users
  user { 'alexis':
    ensure         => present,
    home           => '/home/alexis',
    purge_ssh_keys => true,
    managehome     => true,
  }

  # Authorized SSH Keys
  ssh_authorized_key { 'alexis@Alexiss-MBP.cascadia.demophoon.com':
    user    => 'alexis',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC0KPW9JSl7bcBaAqIMa9Wxbw6qo5gctFqkP5RCgw+7N9D4dpU0dymD90QTq8cDs8oEDiJkngRPmvs9x6ctx5OJgMLHcPKFgmjnOD947kmNZyog11rIeyP3Z9upSS5L5dHILA7OC5JYSoddNO2PM7q0rs4yu1zfb62hx/i7rN3LVv3Qr/9RX3pmlRz+ew3k07fp9nciDfhzPgKX7keunhWRl/ZIPUV8WtOPdb17bOaWAiPki4Z9eilAww4v5bumW8dfdo+DmNF1O6N74+g5yVrBjFCOnHWp+nUWVeA6No81x2zOcURClYJvU60dzjwytq8JML8GntaPFQpRHrq3b4/j',
    require => User['alexis'],
  }
}
