class webserver::php::service(

) inherits webserver::php {
  Service["php${webserver::php::version}-fpm"] {
    enable => true,
    ensure => running,
  }

}