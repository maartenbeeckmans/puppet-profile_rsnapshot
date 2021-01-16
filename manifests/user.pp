#
#
#
class profile_rsnapshot::user {
  class { 'rsnapshot::user':
    tag => lookup('rsnapshot_tag', String, undef, 'rsnapshot')
  }
}
