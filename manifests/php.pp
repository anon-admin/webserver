class webserver::php(
  Enum['7.2', '7.3'] $version = '7.2',
  Boolean $has_ldap = true,
  Optional[Enum['mysql','pgsql']] $has_database = 'pgsql',
) {

  $packages = [php-common, "php${version}-fpm", "php${version}-gd", "php${version}-json",  "php${version}-cli", "php${version}-curl", "php${version}-readline", "php${version}-mbstring", "php${version}-intl", php-imagick, "php${version}-xml", "php${version}-zip"]
  package{ $packages: }

  if ( $has_ldap ) {
    package{ "php${version}-ldap": }
  }

  if ( $has_database != undef ) {
    package{ "php${version}-${has_database}": }
  }

  service{"php${version}-fpm":}
}