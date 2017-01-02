class openhab::plugins::connectsdk {
  # There's no config required for this, fuck yeah
  exec { 'download_plugin':
    command => "curl -s https://api.github.com/repos/sprehn/openhab/releases | grep browser_download_url | head -n 1 | cut -d '\"' -f 4 | xargs wget -O org.openhab.binding.connectsdk_latest.jar",
    path    => $::path,
    cwd     => '/opt/openhab/addons',
    creates => '/opt/openhab/addons/org.openhab.binding.connectsdk_latest.jar',
  }
}
