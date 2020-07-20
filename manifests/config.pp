# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include traefik2::config
class traefik2::config {
  file { $traefik2::config_dir:
    ensure => directory,
  }
  -> file { 'traefik static config':
    path    => "${traefik2::config_dir}/config.yaml",
    content => inline_template('<%= @static_config.to_yaml %>')
  }
  -> file { 'traefik dynamic_config':
    path    => "${traefik2::config_dir}/dynamic.yaml",
    content => inline_template('<%= @dynamic_config.to_yaml %>')
  }
}
