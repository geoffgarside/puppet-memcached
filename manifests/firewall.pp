class memcached::firewall {

  # validate type and convert string to boolean if necessary
  if is_string($::memcached::manage_firewall) {
    $manage_firewall = str2bool($::memcached::manage_firewall)
  } else {
    $manage_firewall = $::memcached::manage_firewall
  }

  validate_bool($manage_firewall)

  if $manage_firewall == true {
    firewall { "100_tcp_${tcp_port}_for_memcached":
      port   => $tcp_port,
      proto  => 'tcp',
      action => 'accept',
    }

    firewall { "100_udp_${udp_port}_for_memcached":
      port   => $udp_port,
      proto  => 'udp',
      action => 'accept',
    }
  }

}
