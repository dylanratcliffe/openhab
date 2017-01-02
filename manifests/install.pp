class openhab::install {
  class {'java':
    distribution          => 'jdk',
    package               => 'oracle-java8-jdk',
    java_alternative      => 'jdk-8-oracle-arm-vfp-hflt',
    java_alternative_path => '/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/jre/bin/java',
  }

  file { '/opt/openhab':
    ensure => 'directory',
    owner  => 'openhab',
    group  => 'openhab',
    mode   => '0755',
    before => Archive['openhab_install'],
  }

  archive { 'openhab_install':
    path          => '/tmp/openhab.zip',
    source        => 'https://openhab.ci.cloudbees.com/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-online/target/openhab-online-2.0.0-SNAPSHOT.zip',
    checksum      => '761181c9d1be5d91bea03ba4e9be33b0',
    checksum_type => 'md5',
    extract       => true,
    extract_path  => $openhab::install_path,
    creates       => "${openhab::install_path}/userdata",
    cleanup       => true,
    user          => 'openhab',
    group         => 'openhab',
    require       => [User['openhab'],Group['openhab']],
  }

  user { 'openhab':
    ensure => present,
  }

  group { 'openhab':
    ensure => present,
  }

  file { 'openhab_systemd':
    ensure => 'file',
    path   => '/lib/systemd/system/openhab.service',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/openhab/openhab.service',
    notify => Service['openhab'],
  }

  service { 'openhab':
    ensure  => 'running',
    require => [User['openhab'],Archive['openhab_install']],
  }

}
