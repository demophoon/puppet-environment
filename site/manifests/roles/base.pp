$latest_packages = [
    'vim',
    'emacs',
    'apache2',
    'fail2ban',
]

package { $latest_packages:
    ensure => latest,
}
