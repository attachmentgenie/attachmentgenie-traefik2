# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include traefik2::install
class traefik2::install {
  case $::traefik2::install_method {
    'archive': {
      $version_dir = "${traefik2::data_dir}/traefik-${traefik2::version}"
      $binary_path = "${version_dir}/traefik"

      file { [$traefik2::data_dir, $version_dir]:
        ensure => directory,
      }
      -> archive { "${binary_path}.tar.gz":
        ensure       => present,
        source       => "https://github.com/containous/traefik/releases/download/v${traefik2::version}/traefik_v${traefik2::version}_linux_amd64.tar.gz",
        extract      => true,
        extract_path => $version_dir,
        creates      => $binary_path,
        cleanup      => false,
      }

      file {
        $binary_path:
          ensure  => file,
          mode    => '0755',
          require => Archive["${binary_path}.tar.gz"],
        ;
        "${traefik2::bin_dir}/traefik":
          ensure  => link,
          target  => $binary_path,
          require => File[$binary_path],
          notify  => Service['traefik2'],
        ;
      }
    }
    'package': {
      package { 'traefik2':
        ensure => $::traefik2::package_version,
        name   => $::traefik2::package_name,
      }
    }
    default: {
      fail("Installation method ${::traefik2::install_method} not supported")
    }
  }
}
