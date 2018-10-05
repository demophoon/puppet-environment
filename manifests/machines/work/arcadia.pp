class profiles::machines::work::arcadia (
  $username = 'britt',
) {
  include profiles::roles::apps
  include profiles::roles::apps::slack
  include profiles::roles::apps::osx

  Package {
    ensure   => present,
    provider => 'homebrew',
  }

  Exec {
    path        => '/bin:/usr/bin:/usr/local/bin',
    user        => $username,
    environment => ["HOME=/Users/${username}"],
    refreshonly => true,
  }

  package { [
    'npm',
    'hyperestraier',
    'gnupg@1.4',
    'pandoc',
    'libyaml',
    'gnu-sed',
    'gawk',
    'gnutls',
    'gnu-indent',
    'gnu-getopt',
    'grep',
    'postman',
    ## Listing deps which are already handled elsewhere so that we can export this if needed.
    # 'wget',
    # 'gnu-tar',
  ]: }

 package { 'nvim': } -> package { 'neovim':
   ensure   => latest,
   provider => 'pip',
 }

  package { 'gettext': } ~>
  exec { 'brew link gettext --force': }

  package { 'mongodb@3.4': } ~>
  exec { [
    'launchctl load /usr/local/Cellar/mongodb*/3.*/homebrew.mxcl.mongodb*.plist',
    'brew services start $(brew services list|awk \'/^mongodb/ {print $1}\')',
  ]: }

  package { 'virtualenvwrapper':
    ensure   => latest,
    provider => 'pip',
  }
}
