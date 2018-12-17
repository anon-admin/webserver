class webserver::nginx::no_default (

) inherits webserver::nginx {
  File["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"] {
    ensure => absent,
  }
}