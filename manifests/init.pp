class openhab (
  $ensure  = 'present',
  $version = 'stable',
){
  anchor { 'openhab_start': }
  anchor { 'openhab_end': }

  include openhab::install
}
