class webserver::nginx (

) inherits webserver {

  package { "nginx": }
  file { ["/etc/nginx", "/etc/nginx/sites-available", "/etc/nginx/sites-enabled"]: }
  file { ["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"]: }
  service { "nginx": }

  if ( ( $webserver::has_webserver ) and ( $webserver::webserver_type == "nginx" ) ){
    Package["nginx"] {
      ensure => latest,
    }

    File["/etc/nginx", "/etc/nginx/sites-available", "/etc/nginx/sites-enabled"] {
      ensure  => directory,
      mode    => '644',
      group   => 'www-data',
      require => Package["nginx"],
    }

    File["/etc/nginx/sites-available/default", "/etc/nginx/sites-enabled/default"] {
      before  => Service["nginx"],
    }

    Service["nginx"]  {
      ensure  => running,
      enable  => true,
      require => Package["nginx"],
    }


    tidy { '/var/log/nginx':
      age     => '3w',
      recurse => 1,
    }

    include webserver::nginx::no_default

#    if  ( $is_gw ) {
#
#
#
#      if ( $has_docserver ) {
#        $docserver_hostname_full=localhost
#      } else {
#        $docserver_hostname=split( $doc_server, '[.]' )[0]
#        $docserver_hostname_full="${docserver_hostname}.${domain}"
#      }
#
#      $gitserver_hostname=split( $git_server, '[.]' )[0]
#      $gitserver_hostname_full="${gitserver_hostname}.${domain}"
#
#      file { "/etc/nginx/snippets/certs.conf":
#        content => template ("webserver/certs.conf.epp"),
#      }
#
#      file { "/etc/nginx/sites-enabled/${hostname}":
#        ensure  => link,
#        target  => "/etc/nginx/sites-available/${hostname}",
#        require => File["/etc/nginx/sites-available/${hostname}"],
#      }
#      file { "/etc/nginx/sites-available/${hostname}":
#        mode    => '644',
#        group   => 'www-data',
#        before  => Service["nginx"],
#        notify  => Service["nginx"],
#        content => epp("webserver/webserver.epp"),
#      }
#    }

  }
}