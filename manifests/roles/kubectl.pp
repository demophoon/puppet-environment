class profiles::roles::kubectl (
) inherits profiles::params {
  include apt

  package { 'kubectl':
    ensure =>  latest,
  }

  apt::source { 'kubernetes':
    location => 'https://apt.kubernetes.io/',
    repos    => 'main',
    release  => 'kubernetes-xenial',
    key      => {
      id     => '59FE0256827269DC81578F928B57C5C2836F4BEB',
      source => 'https://packages.cloud.google.com/apt/doc/apt-key.gpg',
    },
    include  => {
      src => false,
      def => true,
    },
  }

  Apt::Source['kubernetes'] ~>
  Class['apt::update'] ->
  Package['kubectl']
}
