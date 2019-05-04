class profiles::roles::apps::vscode () {
  if $::facts['os']['name'] == 'Ubuntu' {
    include ::snapd
    package { 'code-insiders':
      ensure   => latest,
      provider => 'snap',
    }
  }
}
