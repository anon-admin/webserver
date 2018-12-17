class webserver (
  $domain = $cconf::domain,
  $is_metal = $cconf::is_metal,
  $is_gw = $cconf::is_gw,
  $has_webserser = $cconf::has_webserver,
  $has_nextcloud = $cconf::has_nextcloud,
  $nextcloud_server = $cconf::nextcloud_server,
  $doc_server = $cconf::doc_server,  
  $git_server = $cconf::git_server,
  $docserver_protocol = $cconf::docserver_protocol,
  $docserver_port = $cconf::docserver_port,
  Enum["nginx", "apache2"] $webserver_type = "nginx",
) inherits cconf {

  if ( $has_webserver ) {

    if ($webserver_type == "nginx") {
      include webserver::nginx
    } else {
      include webserver::no_nginx
    }

    if ($webserver_type == "apache2") {
      include webserver::apache2
    } else {
      include webserver::no_apache2
    }


  }

}