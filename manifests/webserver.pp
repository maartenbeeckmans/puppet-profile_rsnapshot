#
#
#
class profile_rsnapshot::webserver {
  include profile_apache
  profile_apache::vhost { $facts['networking']['fqdn']:
    docroot => "/var/www/${facts['networking']['fqdn']}",
  }
}
