class memcached::config {

  $_file_ensure = $::memcached::package_ensure ? {
    'absent' => 'absent',
    default  => 'file',
  }

  $logfile         = $::memcached::logfile
  $verbosity       = $::memcached::verbosity
  $max_memory      = $::memcached::max_memory
  $lock_memory     = $::memcached::lock_memory
  $use_sasl        = $::memcached::use_sasl
  $unix_socket     = $::memcached::unix_socket
  $listen_ip       = $::memcached::listen_ip
  $tcp_port        = $::memcached::tcp_port
  $udp_port        = $::memcached::udp_port
  $user            = $::memcached::user
  $max_connections = $::memcached::max_connections
  $processorcount  = $::memcached::processorcount
  $item_size       = $::memcached::item_size
  $auto_removal    = $::memcached::auto_removal
  $service_name    = $::memcached::params::service_name

  file { $memcached::params::config_file:
    ensure  => $_file_ensure,
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template($memcached::params::config_tmpl),
  }

}
