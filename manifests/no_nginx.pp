class webserver::no_nginx (

) inherits webserver::nginx {
  Package["nginx"] {
    ensure => purged,
  }

  File["/etc/nginx", "/etc/nginx/sites-available", "/etc/nginx/sites-enabled"] {
    ensure  => absent,
  }

  File["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"] {
    ensure  => absent,
  }

  Service["nginx"]  {
    ensure  => stopped,
    enable  => false,
  }
}