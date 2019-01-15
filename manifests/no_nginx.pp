class webserver::no_nginx (

) inherits webserver::nginx {
  Package['nginx'] {
    ensure => purged,
  }

  File[$webserver::nginx::config_dir, $webserver::nginx::globalconf_dir, "${webserver::nginx::config_dir}/sites-available", "${webserver::nginx::config_dir}/sites-enabled"] {
    ensure  => absent,
  }

  File["${config_dir}/nginx.conf","${webserver::nginx::config_dir}/sites-available/default", "${webserver::nginx::config_dir}/sites-enabled/default"] {
    ensure  => absent,
  }

  File[$webserver::nginx::config_dir] {
    ensure => absent,
  }

  Service['nginx']  {
    ensure  => stopped,
    enable  => false,
  }
}