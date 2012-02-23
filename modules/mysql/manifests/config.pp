class mysql::config {
  exec {
    'setup_mysql_pass_root':
      path    => '/usr/bin',
      command => "mysqladmin -uroot -h localhost password $mysql::rootpass",
      onlyif  => 'mysql -uroot -h localhost',
  }
}
