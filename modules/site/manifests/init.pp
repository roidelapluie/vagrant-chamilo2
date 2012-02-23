class site {
  service {
    'iptables':
      ensure => stopped,
      enable => false,
  }

}
