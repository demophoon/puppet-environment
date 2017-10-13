class profiles::components::users {
  # Users
  @user { 'fgresham':
    ensure         => present,
    home           => '/home/fgresham',
    purge_ssh_keys => true,
    managehome     => true,
    tag            => ['tx.dc'],
  }

  # Authorized SSH Keys
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
