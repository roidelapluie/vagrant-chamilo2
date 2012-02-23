class php {
  package {
    'php':
      ensure => installed,
      notify => Service['httpd'],
  }
}
