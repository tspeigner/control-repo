# This class installs the necessary components to become a Distelli Buildserver
class profile::app::cd4pe_buildserver::windows
  {
  file { 'c:/tmp':
    ensure   => directory,
  }

  Package {
    ensure   => latest,
    provider => chocolatey,
  }
  package {'Wget':}
  package {'docker':}
  package {'pdk':}

  # If this cacert isn't placed and used, ruby version managers will croak
  file { 'C:/cacert':
    ensure => directory,
    group  => 'Administrators',
  }

  file { 'Cacert File':
    ensure  => present,
    source  => 'http://curl.haxx.se/ca/cacert.pem',
    group   => 'Administrators',
    path    => 'C:/cacert/cacert.pem',
    require => File['C:/cacert'],
  }

  windows_env {'SSL_CERT_FILE':
    ensure    => present,
    variable  => 'SSL_CERT_FILE',
    value     => 'c:/cacert/cacert.pem',
    mergemode => clobber,
  }

  windows_env {'PATH':
    ensure    => present,
    variable  => 'PATH',
    value     => ['C:\Program Files\Puppet Labs\DevelopmentKit\private\ruby\2.4.4\bin', 'C:\Program Files\Amazon\cfn-bootstrap', 'C:\Program Files\Git\bin'],
    separator => ';',
    mergemode => prepend,
  }

# This is a shim so that the buildserver can talk to the local gitlab container
  file { 'C:/Windows/System32/config/systemprofile/.ssh':
    ensure => directory,
    owner  => 'Administrator',
    group  => 'Administrators',
    mode   => '0770',
  }

  file { 'C:/Windows/System32/config/systemprofile/.ssh/config':
    ensure  => present,
    owner   => 'Administrator',
    group   => 'Administrators',
    mode    => '0770',
    source  => 'puppet:///modules/profile/app/cd4pe_buildserver/distelli.ssh.config',
    require => File['C:/Windows/System32/config/systemprofile/.ssh'],
  }
}
