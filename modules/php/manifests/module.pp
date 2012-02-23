define php::module {
  package {
    "php-$name":
      ensure  => installed,
      notify  => Service['httpd'],
      require => Package['php'],
  }
}
