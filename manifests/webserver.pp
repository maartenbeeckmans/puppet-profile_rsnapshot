#
#
#
class profile_rsnapshot::webserver {
  include profile_nginx
  profile_nginx::vhost { $facts['networking']['fqdn']:
    autoindex => 'on',
  }
}
