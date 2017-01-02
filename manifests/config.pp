class openhab::config {
  vcsrepo { '/opt/openhab/conf':
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/dylanratcliffe/openhab_config.git',
    revision => 'master',
    owner    => 'openhab',
    group    => 'openhab',
    require  => Class['openhab::install'],
  }
}
