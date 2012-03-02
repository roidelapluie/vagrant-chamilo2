node chamilo2 {
  include apache
  include mercurial
  include site
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
node chamilo2-stable inherits chamilo2 {
  include chamilo
}

node chamilo2-dev inherits chamilo2 {
  class {
    'chamilo':
      version => 'dev',
  }
}
