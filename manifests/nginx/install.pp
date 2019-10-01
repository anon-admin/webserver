class webserver::nginx::install(

) inherits  webserver::nginx {
  Package[$webserver::nginx::packages] {
    ensure => latest,
  }
}