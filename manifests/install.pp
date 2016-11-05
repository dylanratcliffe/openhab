class openhab::install {
  class {'java':
    distribution          => 'jdk',
    package               => 'oracle-java8-jdk',
    java_alternative      => 'jdk-8-oracle-arm-vfp-hflt',
    java_alternative_path => '/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt/jre/bin/java',
  }

  include apt

  apt::source { 'openhab':
    location => 'http://dl.bintray.com/openhab/apt-repo',
    release  => $openhab::version,
    repos    => 'main',
    key      => 'EDB7D0304E2FCAF629DF1163075721F6A224060A',
  }

  package { 'openhab-runtime':
    ensure  => $openhab::ensure,
    require => Apt::Source['openhab'],
    notify  => Service['openhab'],
  }

  user { 'openhab':
    ensure  => present,
    groups  => [ 'dialout' ],
    require => Package['openhab-runtime'],
  }

  service { 'openhab':
    ensure  => running,
    enable  => true,
    require => Package['openhab-runtime']
  }

}
