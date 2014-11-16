# == Class: memcached
#
# Manage memcached
#
class memcached (
  $package_ensure  = $::memcached::params::package_ensure,
  $logfile         = $::memcached::params::logfile,
  $manage_firewall = $::memcached::params::manage_firewall,
  $max_memory      = $::memcached::params::max_memory,
  $item_size       = $::memcached::params::item_size,
  $lock_memory     = $::memcached::params::lock_memory,
  $listen_ip       = $::memcached::params::listen_ip,
  $tcp_port        = $::memcached::params::tcp_port,
  $udp_port        = $::memcached::params::udp_port,
  $user            = $::memcached::params::user,
  $max_connections = $::memcached::params::max_connections,
  $verbosity       = $::memcached::params::verbosity,
  $unix_socket     = $::memcached::params::unix_socket,
  $install_dev     = $::memcached::params::install_dev,
  $processorcount  = $::memcached::params::processorcount,
  $service_restart = $::memcached::params::service_restart,
  $auto_removal    = $::memcached::params::auto_removal,
  $use_sasl        = $::memcached::params::use_sasl,
) inherits memcached::params {

  validate_bool($service_restart)

  class { '::memcached::install': }->
  class { '::memcached::config': }->
  class { '::memcached::firewall': }->
  class { '::memcached::service': }->
  Class['memcached']

  if $service_restart {
    Class['::memcached::install'] ~> Class['::memcached::service']
    Class['::memcached::config'] ~> Class['::memcached::service']
  }

}
