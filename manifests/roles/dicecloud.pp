class profiles::roles::dicecloud () {
  package { 'bower':
    ensure   => 'present',
    provider =>  'npm',
  }

  vcsrepo { '/opt/dicecloud/':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/ThaumRystra/DiceCloud1',
  }
}
