class chamilo ($version = 'stable'){
  if ($version == 'stable'){
    $folder = 'chamilo'
    $get = 'get-all'
  }
  file {
    "/var/www/$folder":
      ensure  => directory,
      require => Class['apache'],
      owner   => 'apache',
      group   => 'apache',
  }

  apache::site {
    'localhost':
      docroot => "/var/www/$folder",
  }

  exec {
    'clone-chamilo':
      command => "hg clone https://bitbucket.org/chamilo/${folder} /var/www/${folder}",
      user    => 'apache',
      creates => "/var/www/${folder}/index.php",
      path    => '/usr/bin',
      require => [Package['mercurial'], File["/var/www/${folder}"]],
  }
  exec {
    'clone-chamilo-modules':
      command => "php script/phing.php $get",
      user    => 'apache',
      creates => "/var/www/${folder}/install/index.php",
      cwd     => "/var/www/${folder}",
      path    => '/usr/bin',
      require => [Package['php'], Exec['clone-chamilo']],
      timeout => 0,
  }
  php::module { ['gd', 'xml', 'mbstring']: }
  php::option {'output_buffering': ensure => 'off'; }
}
