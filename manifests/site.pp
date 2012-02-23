node chamilo2-stable {
  include apache
  include mercurial
  include site
  include chamilo
  include php
  class { 'mysql':
      rootpass => 'sup3rR00t',
  }
  mysql::definitions::user {
    'chamuser':
      pass => 'passw00t',
  }
  mysql::definitions::db {
    'chamdb':
      user => 'chamuser',
  }
}
