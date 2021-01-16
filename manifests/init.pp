#
#
#
class profile_rsnapshot (
  String               $collect_tag,
  Hash                 $intervals,
  Hash                 $timers,
  Stdlib::AbsolutePath $mount_dir,
  String               $data_device,
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
