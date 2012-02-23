define php::option ($ensure) {
  exec {
    "create option $name":
      require => Package['php'],
      notify  => Service['httpd'],
      unless  => "grep \"^${title}\" /etc/php.ini",
      command => "echo \"${title} = $ensure\" >> /etc/php.ini",
      path    => '/bin:/usr/bin',
  }
  exec {
    "set option $name":
      require => Package['php'],
      notify  => Service['httpd'],
      unless  => "grep -x \"${title} = $ensure\" /etc/php.ini",
      command => "sed -i \"s/^\\(${title} =\\).*/\\1 $ensure/\" /etc/php.ini",
      path    => '/bin:/usr/bin',
  }
}
