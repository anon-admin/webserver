class webserver::php::latest inherits webserver::php {


  Package[$webserver::php::packages] {
    ensure => latest,
  }

  if ( $webserver::php::has_ldap ) {
    Package["php${webserver::php::version}-ldap"] {
      ensure => latest,
    }
  }

  if ( $webserver::php::has_database != undef ) {
    Package["php${webserver::php::version}-${webserver::php::has_database}"] {
      ensure => latest,
    }
  }
}