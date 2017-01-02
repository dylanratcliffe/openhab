class openhab (
  $ensure       = 'present',
  $version      = 'stable',
  $install_path = '/opt/openhab',
){
  anchor { 'openhab_start': }
  anchor { 'openhab_end': }

  include openhab::install
  include openhab::config

  include nginx

  nginx::resource::vhost { 'pi.wifredrick.lan':
    listen_port => 80,
    proxy       => 'http://localhost:8080',
  }

  include openhab::plugins::connectsdk

  package { 'mosh':
    ensure => 'latest',
  }

  include openhab::motd
}
