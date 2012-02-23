class mysql (
  $rootpass
) {
  class{
    'mysql::packages':
      before => Class['mysql::service'];
    'mysql::service':
      before => Class['mysql::config'];
    'mysql::config':;
  }
}
