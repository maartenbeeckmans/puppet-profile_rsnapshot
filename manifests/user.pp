#
#
#
class profile_rsnapshot::user {
  class { 'rsnapshot::user':
    tag             => lookup('rsnapshot_tag', String, undef, 'rsnapshot'),
    authorized_keys => lookup('rsnapshot_authorized_keys', Hash, undef, {}),
  }
}
