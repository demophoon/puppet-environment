class profiles::roles::apps::chromium () {
  case $::osfamily {
    'Darwin': { $chromium = 'chromium' }
    default: { $chromium = 'chromium-browser' }
  }
  package { $chromium: }
}
