class { '::consul':
  config_hash => {
    'bootstrap_expect' => 1,
    'client_addr'      => '0.0.0.0',
    'data_dir'         => '/tmp/consul',
    'datacenter'       => 'local',
    'log_level'        => 'INFO',
    'node_name'        => 'consul0',
    'server'           => true,
    'ui_dir'           => '/tmp/consul/ui',
  },
}
