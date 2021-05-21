#
#
#
class profile_rsnapshot (
  Hash                 $intervals,
  Hash                 $timers,
  Stdlib::AbsolutePath $mount_dir,
  String               $data_device,
  Array                $sd_service_tags,
  String               $collect_tag = lookup('rsnapshot_tag', String, undef, 'rsnapshot'),
) {
  profile_base::mount{ $mount_dir:
    device => $data_device,
    before => Class['rsnapshot'],
  }

  class { 'rsnapshot':
    intervals    => $intervals,
    timers       => $timers,
    reports_path => "/var/www/${facts['networking']['fqdn']}",
  }

  include profile_apache

  profile_apache::vhost { $facts['networking']['fqdn']:
    docroot         => "/var/www/${facts['networking']['fqdn']}",
    sd_service_tags => $sd_service_tags,
  }

  # Collect exported resources
  Rsnapshot::Backup <<| tag == $collect_tag |>>
  Rsnapshot::Backup_script <<| tag == $collect_tag |>>
  Sshkey <<| tag == $collect_tag |>>
}
