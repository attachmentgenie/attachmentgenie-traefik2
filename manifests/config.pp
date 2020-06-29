# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include traefik2::config
class traefik2::config {
  $config_file = "${traefik2::config_dir}/traefik2.yaml"

  file { $traefik2::config_dir:
    ensure => directory,
  }
  -> concat { $config_file:
    ensure => present,
    notify => Service['traefik2'],
  }

  concat::fragment { 'traefik2_config_header':
    target  => $config_file,
    content => "---\n",
    order   => '01',
  }
}
