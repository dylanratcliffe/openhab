class openhab::config {
  vcsrepo { '/opt/openhab/conf':
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/dylanratcliffe/openhab.git',
    revision => 'master',
    require  => Class['openhab::install'],
  }
}
