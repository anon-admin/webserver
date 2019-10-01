class webserver::nginx::service(

) inherits webserver::nginx {
  include webserver::nginx::config

  Service['nginx']  {
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }

  file{ $webserver::nginx::log_dir:
    ensure  => directory,
    before => Tidy[$webserver::nginx::log_dir],
  }

  tidy { $webserver::nginx::log_dir:
    age     => '3w',
    recurse => 1,
  }
}