class profiles::machines::work::arcadia (){
  include profiles::roles::apps
  include profiles::roles::apps::slack
  include profiles::roles::apps::osx

  Package {
    ensure   => present,
    provider => 'homebrew',
  }

  Exec {
    path        => '/bin:/usr/bin:/usr/local/bin',
    user        => 'britt',
    environment => ["HOME=/Users/britt"],
  }

  package { [
    'mongodb@3.4',
    'npm',
    'hyperestraier',
    'gnupg@1.4',
    'pandoc',
    'gettext',
    'libyaml',
    'gnu-sed',
    'gawk',
    'gnutls',
    'gnu-indent',
    'gnu-getopt',
    'grep',
    ## Listing deps which are already handled elsewhere so that we can export this if needed.
    # 'wget',
    # 'gnu-tar',
  ]: }

  exec { [
    'brew link gettext --force',
    'launchctl load /usr/local/Cellar/mongodb*/3.*/homebrew.mxcl.mongodb*.plist',
    'brew services start $(brew services list|awk \'/^mongodb/ {print $1}\')',
  ]:
    subscribe => Package['gettext'],
  }
}
