class webserver::nginx (

) inherits webserver {

  $config_dir = '/etc/nginx'
  $globalconf_dir = "${config_dir}/conf.d"
  $log_dir = '/var/log/nginx'
  
  package { 'nginx': }
  file { [$config_dir, $globalconf_dir, "${config_dir}/sites-available", "${config_dir}/sites-enabled"]: }
  file { ["${config_dir}/nginx.conf", "${config_dir}/sites-available/default", "${config_dir}/sites-enabled/default"]: }
  service { 'nginx': }

  if ( ( $webserver::has_webserver ) and ( $webserver::webserver_type == 'nginx' ) ){
    Package['nginx'] {
      ensure => latest,
    }

    File[$config_dir, $globalconf_dir, "${config_dir}/sites-available", "${config_dir}/sites-enabled"] {
      ensure  => directory,
      mode    => '644',
      group   => 'www-data',
      require => Package['nginx'],
    }

    File["${config_dir}/sites-available/default", "${config_dir}/sites-enabled/default"] {
      before  => Service['nginx'],
    }

    Service['nginx']  {
      ensure  => running,
      enable  => true,
      require => Package['nginx'],
    }

    file{ $log_dir:
      before => Tidy[$log_dir],
    }

    tidy { $log_dir:
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
#      file { "${conf_dir}/snippets/certs.conf":
#        content => template ("webserver/certs.conf.epp"),
#      }
#
#      file { "${conf_dir}/sites-enabled/${hostname}":
#        ensure  => link,
#        target  => "${conf_dir}/sites-available/${hostname}",
#        require => File["${conf_dir}/sites-available/${hostname}"],
#      }
#      file { "${conf_dir}/sites-available/${hostname}":
#        mode    => '644',
#        group   => 'www-data',
#        before  => Service['nginx'],
#        notify  => Service['nginx'],
#        content => epp("webserver/webserver.epp"),
#      }
#    }

  }
}