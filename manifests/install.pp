class memcached::install {
  package { $::memcached::params::package_name:
    ensure => $::memcached::package_version,
  }

  if $::memcached::install_dev and $::memcached::params::dev_package_name {
    package { $memcached::params::dev_package_name:
      ensure  => $::memcached::package_version,
      require => Package[$::memcached::params::package_name]
    }
  }
}
