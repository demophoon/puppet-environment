class profiles::linode {
  user { 'fgresham':
    ensure         => present,
    home           => '/home/fgresham',
    purge_ssh_keys => true,
  }

  ssh_authorized_key { 'fgresham@Freds-MacBook-Pro.local':
    user => 'fgresham',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCi9tCkE3ydnxeSthLcEICPhAX91HpX3tdzaYva5SNbzr/OjghCa5QW3FFH0rL9IeHWsu0hXCL9qjtdqtdSNFoPNtjez1buwu78nNCFC+iSqNZIZ0W7z93FMeE7cDWV3VoUBrHv6fWCNdDUeabSdeXJTE004My7GuJhRbCS/LQQkoyg3cGSBdtBcx+nuV5Qek/YFqj7L3pMTaNTCL8//j5fMbJENc7BWDifIoENSLCF4mMYXDitc4TOSP8ycgaekWACxnpCTmgkReXbi987h09tNFpksrvu5jJLeqdr3ZDb3wqlOJLV5FNtRVndh36K6MsuW1q68fwbCkTcIoAA9AW/',
  }
}
