class mysql::service {
  service { 'mysqld':
    ensure      => running,
    enable      => true,
    name        => $::operatingsystem ? {
      default   => 'mysqld',
      debian    => 'mysql',
    },
    path        => $::operatingsystem ? {
      default   => '/etc/init.d',
      archlinux => '/etc/rc.d',
    },
    hasstatus   => $::operatingsystem ? {
      default   => true,
      archlinux => false,
    },
    require     => Package['mysql-server'];
  }
}
