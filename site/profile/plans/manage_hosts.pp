plan profile::manage_hosts (
  TargetSpec $target  = 'local://localhost',
  String[1]  $domain  = 'ts-aws.tsedemos.com',
  String[1]  $disco   = 'awsdiscovery',
  String[1]  $master  = 'awsmaster',
  String[1]  $cd4pe   = 'awscd4pe',
  #Array      $winhost,
) {
  $tf_results   = run_task('profile::tf_output', $target)
  $first        = $tf_results.first
  $tf_pm_ip     = $first[awsmaster][value]
  $tf_pd_ip     = $first[awsdiscovery][value]
  $tf_cd_ip     = $first[awscd4pe][value]
  # $tf_ln_ip     = $first.each[linux_hostname][value]
  $linhost      = $first[linux_hostname]
  #$tf_wn_ip     = $first.each[windows_servers][value]
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
  # apply($target) {
  #   host { $linhost:
  #     ensure       => present,
  #     name         => $linhost,
  #     host_aliases => ["${linhost}.${domain}"],
  #     ip           => $tf_ln_ip,
  #   }
  # }
}
