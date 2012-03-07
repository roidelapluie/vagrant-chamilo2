class chamilo ($version = 'stable'){
  if ($version == 'dev'){
    $folder = 'chamilo-dev'
    $get = 'get-all-dev'
  }
  if ($version == 'stable'){
    $folder = 'chamilo'
    $get = 'get-all'
  }
  file {
    "/var/www/$folder":
      ensure  => directory,
      owner   => 'vagrant',
      group   => 'vagrant',
      require => Class['apache'],
  }

  apache::site {
    'localhost':
      docroot => "/var/www/$folder",
  }

  exec {
    'clone-chamilo':
      command => "hg clone https://bitbucket.org/chamilo/${folder} /var/www/${folder}",
      user    => 'vagrant',
      creates => "/var/www/${folder}/index.php",
      path    => '/usr/bin',
      require => [File["/var/www/${folder}"], Package['mercurial']],
      timeout => 0,
  }
  exec {
    'clone-chamilo-modules':
      command => "php script/phing.php $get",
      user    => 'vagrant',
      creates => "/var/www/${folder}/install/index.php",
      cwd     => "/var/www/${folder}",
      path    => '/usr/bin',
      require => [File["/var/www/${folder}"], Package['php'], Exec['clone-chamilo']],
      timeout => 0,
  }
  php::module { ['gd', 'xml', 'mbstring', 'mysql']: }
  php::option {'output_buffering': ensure => 'off'; }
}
