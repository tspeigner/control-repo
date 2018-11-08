# Add cd4pe and gitlab IP addresses using puppetdb query
class profile::app::cd4pe_buildserver::hosts {

  $master_server = $::settings::server
  
  $cd4pe_query        = "inventory[facts] { facts.trusted.certname ~ 'cd4pe' }"
  $response           = puppetdb_query($cd4pe_query)
  $cd4pe_ip           = $response[0]['facts']['ipaddress']

  host { 'cd4pe.ts-aws.puppet.vm':
    ensure       => 'present',
    ip           => $cd4pe_ip,
    host_aliases => ['cd4pe'],
  }

}
