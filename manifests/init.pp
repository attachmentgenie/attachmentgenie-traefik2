# @summary Install, configure, and run Traefik as a confined edge proxy.
#
# @example
#   include traefik2
class traefik2 (
  Stdlib::Absolutepath $bin_dir,
  Stdlib::Absolutepath $config_dir,
  Stdlib::Absolutepath $data_dir,
  Hash $dynamic_config,
  Enum['archive','package'] $install_method,
  Boolean $manage_service,
  String[1] $package_name,
  String[1] $package_version,
  String[1] $service_name,
  Enum['systemd'] $service_provider,
  Enum['running','stopped'] $service_ensure,
  Hash $static_config,
  String[1] $version,

  # De-root: run as a dedicated, unprivileged system user instead of
  # root. AmbientCapabilities=CAP_NET_BIND_SERVICE on the systemd unit
  # lets it still bind :80/:443 without root. Set manage_user => false
  # if the user/group already exist (e.g. managed elsewhere).
  String[1] $user           = 'traefik',
  String[1] $group          = 'traefik',
  Boolean   $manage_user    = true,

  Optional[Stdlib::Absolutepath] $systemd_workdir = undef
) {
  if $manage_user {
    contain 'traefik2::user'
    Class['traefik2::user'] -> Class['traefik2::install']
  }

  contain 'traefik2::install'
  contain 'traefik2::config'
  contain 'traefik2::service'

  Class['traefik2::install']
  -> Class['traefik2::config']
  ~> Class['traefik2::service']
}
