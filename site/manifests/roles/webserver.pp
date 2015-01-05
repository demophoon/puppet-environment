$latest_packages = [
    'fail2ban',
    'apache2',
]

package { $latest_packages:
    ensure => latest,
}
