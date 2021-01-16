#
#
#
class profile_rsnapshot (
  Hash                 $intervals,
  Hash                 $timers,
  Stdlib::AbsolutePath $mount_dir,
  String               $data_device,
  String               $collect_tag = lookup('rsnapshot_tag', String, undef, 'rsnapshot'),
) {
  profile_base::mount{ $mount_dir:
    device => $data_device,
    before => Class['rsnapshot'],
  }

  class { 'rsnapshot':
    intervals => $intervals,
    timers    => $timers,
  }

  #include profile_rsnapshot::webserver

  # Collect exported resources
  Rsnapshot::Backup <<| tag == $collect_tag |>>
  Rsnapshot::Backup_script <<| tag == $collect_tag |>>
  Sshkey <<| tag == $collect_tag |>>
}
