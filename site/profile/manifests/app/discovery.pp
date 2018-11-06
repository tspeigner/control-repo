class profile::app::discovery (
  $pd_url     = 'https://goo.gl/e1Jsi1', #shortened URL of Discovery download
  $pd_license = 'https://goo.gl/SRtH7x', #license file on S3
  $license_file = '/root/puppet_discovery/discovery.license.json'
) {
  # Baseline and install Docker
  require ::profile::platform::baseline
  require ::profile::app::docker

  #Create download directory
  file {'/root/puppet_discovery':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }
  # Download file
  file { '/root/puppet_discovery/puppet-discovery':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => $pd_url,
  }
  file { $license_file:
    ensure => 'file',
    source => $pd_license,
    owner  => 'root',
    group  => 'root',
  }

}
