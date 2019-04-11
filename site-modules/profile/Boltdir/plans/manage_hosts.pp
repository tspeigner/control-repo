plan profile::manage_hosts (
  TargetSpec $target  = 'local://localhost',
  String[1]  $domain  = 'ts-aws.tsedemos.com',
  String[1]  $disco   = 'awsdiscovery',
  String[1]  $master  = 'awsmaster',
  String[1]  $cd4pe   = 'awscd4pe',
  #Array      $winhost,
) {
  # the results of running the tf_output script, which is a terraform output command to json.
  $tf_results   = run_task('profile::tf_output', $target)
  # get the first block of code
  $first        = $tf_results.first
  # create a new value for the puppet master ip
  $tf_pm_ip     = $first[awsmaster][value]
  # create a new value for discovery server ip
  $tf_pd_ip     = $first[awsdiscovery][value]
  #create a new value for cd4pe server ip
  $tf_cd_ip     = $first[awscd4pe][value]
  # create value for linux hostnames
  $linhost      = $first[linux_hostname][value]
  # create value for linux ips
  $linip        = $first[linux_ip][value]
  # taking an array of values, mapping them to an array, reducing the new values to a new array.
  # {linux-01.ts-puppet.vm => 34.222.234.92, linux-02.ts-puppet.vm => 34.220.150.81}
  # iterate over the $linhost value and place them in a new array as the first key
  # iterate over the $linip value and place them in a new array s the second key
  $host2ip      = $linhost.map |$index,$element| {
    {$linhost[$index] => $linip[$index]}
  }.reduce({}) |$hash, $element| {
    # results are a new array with $linhost $linip for each instance in the orginal array values.
    $hash + $element
  }
  $linhost      = $first[linux_hostname]
  $tf_wn_ip     = $first.each[windows_servers][value]
  apply($target) {
    host { $master:
      ensure       => present,
      name         => $master,
      host_aliases => ["puppet.${domain}"],
      ip           => $tf_pm_ip,
    }
  }
  apply($target) {
    host { $disco:
      ensure       => present,
      name         => $disco,
      host_aliases => ["discovery.${domain}"],
      ip           => $tf_pd_ip,
    }
  }
  apply($target) {
    host { $cd4pe:
      ensure       => present,
      name         => $cd4pe,
      host_aliases => ["cd4pe.${domain}"],
      ip           => $tf_cd_ip,
    }
  }
  apply($target) {
    host { $linhost:
      ensure       => present,
      name         => $linhost,
      host_aliases => ["${host2ip}"],
      ip           => $tf_ln_ip,
    }
  }
}
