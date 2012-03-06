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
    "/var/www/$folder/files":
      ensure  => directory,
      mode    => '0777',
      require => Exec['clone-chamilo-modules'],
  }
  file {
    "/var/www/$folder/common/configuration":
      ensure  => directory,
      mode    => '0777',
      require => Exec['clone-chamilo-modules'],
  }
  file {
    "/var/www/$folder":
      ensure  => directory,
      require => Class['apache'],
  }

  file {
   '/root/.hgrc':
     ensure  => present,
     content => "[paths]\ndefault = https://bitbucket.org/chamilo/${folder}\n",
     require => Package['mercurial'],


  }

  apache::site {
    'localhost':
      docroot => "/var/www/$folder",
  }

  exec {
    'clone-chamilo':
      command => "hg clone https://bitbucket.org/chamilo/${folder} /var/www/${folder}",
      creates => "/var/www/${folder}/index.php",
      path    => '/usr/bin',
      require => [File['/root/.hgrc'], File["/var/www/${folder}"], Package['php']],
      timeout => 0,
  }
  exec {
    'clone-chamilo-modules':
      command => "php script/phing.php $get",
      creates => "/var/www/${folder}/install/index.php",
      cwd     => "/var/www/${folder}",
      path    => '/usr/bin',
      require => [File['/root/.hgrc'], File["/var/www/${folder}"], Package['php']],
      timeout => 0,
  }
  php::module { ['gd', 'xml', 'mbstring', 'mysql']: }
  php::option {'output_buffering': ensure => 'off'; }
}
