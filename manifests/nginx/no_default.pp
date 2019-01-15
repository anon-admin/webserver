class webserver::nginx::no_default (

) inherits webserver::nginx {
  File["${webserver::nginx::config_dir}/sites-available/default", "${webserver::nginx::config_dir}/sites-enabled/default"] {
    ensure => absent,
  }
}