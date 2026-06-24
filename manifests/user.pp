# @summary Dedicated system account Traefik runs as (de-root).
class traefik2::user {
  group { $traefik2::group:
    ensure => present,
    system => true,
  }

  user { $traefik2::user:
    ensure     => present,
    system     => true,
    gid        => $traefik2::group,
    shell      => '/usr/sbin/nologin',
    home       => $traefik2::data_dir,
    managehome => false,
    require    => Group[$traefik2::group],
  }
}
