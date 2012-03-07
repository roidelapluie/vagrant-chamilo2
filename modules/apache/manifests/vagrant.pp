class apache::vagrant {
  exec {'sed "s/^Group.*$/Group apache/" -i /etc/httpd/conf/httpd.conf':
    path    => '/bin:/usr/bin',
    unless  => 'grep "^Group apache$" /etc/httpd/conf/httpd.conf',
    require => Class['apache::install'],
    notify  => Service['httpd'],
  }
  exec {'sed "s/^User.*$/User vagrant/" -i /etc/httpd/conf/httpd.conf':
    path   => '/bin:/usr/bin',
    unless => 'grep "^User vagrant$" /etc/httpd/conf/httpd.conf',
    require => Class['apache::install'],
    notify  => Service['httpd'],
  }
}
