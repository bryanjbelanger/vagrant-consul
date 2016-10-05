# == Class: class_name
#
class { '::firewall':
  ensure => stopped,
  before => Class['::consul'],
}

package { 'unzip':
  ensure => installed,
  before => Class['::consul'],
}

class { '::consul':
  config_hash => {
    'bootstrap_expect' => 1,
    'bind_addr'        => $::facts['networking']['interfaces']['enp0s3']['ip'],
    'client_addr'      => '0.0.0.0',
    'data_dir'         => '/tmp/consul',
    'datacenter'       => 'local',
    'log_level'        => 'INFO',
    'node_name'        => 'consul0',
    'server'           => true,
    'ui_dir'           => '/tmp/consul/ui',
  },
}
