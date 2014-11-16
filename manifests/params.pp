# == Class: memcached::params
#
class memcached::params {
  $package_version = 'present'
  $manage_firewall = false
  $max_memory      = false
  $item_size       = false
  $lock_memory     = false
  $listen_ip       = '0.0.0.0'
  $tcp_port        = 11211
  $udp_port        = 11211
  $max_connections = '8192'
  $verbosity       = undef
  $unix_socket     = undef
  $install_dev     = false
  $processorcount  = $::processorcount

  $service_restart = true
  $auto_removal    = false
  $use_sasl        = false

  case $::osfamily {
    'Debian': {
      $package_name       = 'memcached'
      $service_name       = 'memcached'
      $service_hasstatus  = false
      $service_hasrestart = true
      $dev_package_name   = 'libmemcached-dev'
      $config_file        = '/etc/memcached.conf'
      $config_tmpl        = "${module_name}/memcached.conf.erb"
      $user               = 'nobody'
    }
    /RedHat|Suse/: {
      $package_name       = 'memcached'
      $service_name       = 'memcached'
      $service_hasstatus  = true
      $service_hasrestart = true
      $dev_package_name   = 'libmemcached-devel'
      $config_file        = '/etc/sysconfig/memcached'
      $config_tmpl        = "${module_name}/memcached_sysconfig.erb"
      $user               = 'memcached'
    }
    'Darwin': {
      $package_name       = 'memcached'
      $service_name       = 'homebrew.mxcl.memcached'
      $service_hasstatus  = true
      $service_hasrestart = false
      $dev_package_name   = false
      $config_file        = "/Library/LaunchDaemons/${service_name}.plist"
      $config_tmpl        = "${module_name}/memcached.plist.erb"
      $user               = 'nobody'
    }
    default: {
      case $::operatingsystem {
        'Amazon': {
          $package_name       = 'memcached'
          $service_name       = 'memcached'
          $service_hasstatus  = true
          $service_hasrestart = false
          $dev_package_name   = 'libmemcached-devel'
          $config_file        = '/etc/sysconfig/memcached'
          $config_tmpl        = "${module_name}/memcached_sysconfig.erb"
          $user               = 'memcached'
        }
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
