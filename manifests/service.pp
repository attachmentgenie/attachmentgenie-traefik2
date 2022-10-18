# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include traefik2::service
class traefik2::service {
  if $traefik2::manage_service {
    case $traefik2::service_provider {
      'systemd': {
        ::systemd::unit_file { "${traefik2::service_name}.service":
          content => epp('traefik2/traefik2.service.epp'),
          before  => Service['traefik2'],
        }
      }
      default: {
        fail("Service provider ${traefik2::service_provider} not supported")
      }
    }

    case $traefik2::install_method {
      'archive': {}
      'package': {
        Service['traefik2'] {
          subscribe => Package['traefik2'],
        }
      }
      default: {
        fail("Installation method ${traefik2::install_method} not supported")
      }
    }

    service { 'traefik2':
      ensure   => $traefik2::service_ensure,
      enable   => true,
      name     => $traefik2::service_name,
      provider => $traefik2::service_provider,
    }
  }
}
