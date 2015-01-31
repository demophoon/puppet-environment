class roles::base {
    $latest_packages = [
        'vim',
        'emacs',
        'zsh',
        'bash',
        'ntp',
    ]

    package { $latest_packages:
        ensure => latest,
    }
}
