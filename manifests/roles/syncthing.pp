class profiles::roles::syncthing () {
  $config = '/home/britt/.syncthing'
  $notes = '/home/britt/Notes'

  file { [$config, $notes]:
    ensure => 'directory',
    owner  => 'britt',
    group  => 'britt',
  } ->
  class { 'syncthing':
    instances => {
      'default' =>  {
        home_path  => $config,
        daemon_uid =>  'britt',
        daemon_gid =>  'britt',
      }
    },
    folders   => {
      'Notes' => {
        home_path     => $config,
        instance_name => 'default',
        path          => $notes,
        id            => 'lzkjg-dc276',
        devices       => {
          'T4RVCO6-TZYKBUL-NHHVBL4-AK4OUGA-FAUXVTS-Q55C7U4-OXFPR65-XQ6FFQ2' => 'present',
        }
      },
    },
    devices   => {
      'beryllium' => {
        home_path     => $config,
        instance_name => 'default',
        id            =>  'T4RVCO6-TZYKBUL-NHHVBL4-AK4OUGA-FAUXVTS-Q55C7U4-OXFPR65-XQ6FFQ2',
      },
    }
  }

}
