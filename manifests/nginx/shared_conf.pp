class webserver::nginx::shared_conf (

) inherits webserver::nginx {
  File["${webserver::nginx::config_dir}/nginx.conf"] {
    content => epp("webserver/nginx.conf.epp"),
    notify  => Service["nginx"],
  }
}