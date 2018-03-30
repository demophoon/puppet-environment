class profiles::roles::development::ruby (
  $ruby_versions = [
    '2.2.5',
  ],
  $default_gems = [],
) {
  class { 'rbenv':
    latest => true,
  }

  rbenv::plugin { 'rbenv/ruby-build': }

  $ruby_versions.each |$version| {
    rbenv::build { $version: }

    $default_gems.each |$gem| {
      rbenv::gem { $gem:
        ruby_version => $version,
      }
    }

  }
}
