# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include traefik2::config
class traefik2::config {
  file { $traefik2::config_dir:
    ensure => directory,
    owner  => $traefik2::user,
    group  => $traefik2::group,
  }
  -> file { 'traefik static config':
    path    => "${traefik2::config_dir}/config.yaml",
    owner   => $traefik2::user,
    group   => $traefik2::group,
    mode    => '0640',
    content => inline_epp('<%= $config.to_yaml %>', { 'config' => $traefik2::static_config }),
  }
  -> file { 'traefik dynamic_config':
    path    => "${traefik2::config_dir}/dynamic.yaml",
    owner   => $traefik2::user,
    group   => $traefik2::group,
    mode    => '0640',
    content => inline_epp('<%= $config.to_yaml %>', { 'config' => $traefik2::dynamic_config }),
  }
}
