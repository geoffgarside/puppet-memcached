class memcached::service {

  if $::memcached::package_ensure == 'absent' {
    $service_ensure = 'stopped'
    $service_enable = false
  } else {
    $service_ensure = 'running'
    $service_enable = true
  }

  service { $::memcached::params::service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasrestart => $::memcached::params::service_hasrestart,
    hasstatus  => $::memcached::params::service_hasstatus,
  }
}
