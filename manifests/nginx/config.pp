class webserver::nginx::config (

) inherits webserver::nginx {
  include webserver::nginx::install

  File[$webserver::nginx::config_dir, $webserver::nginx::globalconf_dir, "${webserver::nginx::config_dir}/sites-available", "${webserver::nginx::config_dir}/sites-enabled"] {
    ensure  => directory,
    mode    => '644',
    group   => 'www-data',
    require => Package[$webserver::nginx::packages],
  }

  File["${webserver::nginx::config_dir}/sites-available/default", "${webserver::nginx::config_dir}/sites-enabled/default"] {
    before  => Service['nginx'],
  }
}