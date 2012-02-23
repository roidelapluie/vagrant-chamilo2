define mysql::definitions::db (
  $user,
  $host = 'localhost',
  $perms = 'all'
){
  exec {
    "create_db_$name":
      command => "mysqladmin -uroot -p$mysql::rootpass -h \"$host\" create \"$name\"; mysql -uroot -p$mysql::rootpass -h \"$host\" -e \"grant $perms on $name.* to '$user'@'$host'\"",
      path    => '/usr/bin:/bin:/sbin',
      unless  => "mysql -uroot -p$mysql::rootpass -h \"$host\" -e 'use $name'",
      require => Mysql::Definitions::User[$user],
  }
}
