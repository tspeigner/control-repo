plan profile::manage_hosts (
  TargetSpec $target  = 'local://localhost',
  String[1]  $disco   = 'awsdiscovery',
  String[1]  $pmaster = 'awsmaster'
) {
  $tf_results   = run_task('profile::tf_output', $target)
  $first        = $tf_results.first
  $tf_pm_ip     = $first[puppet_master][value]
  $tf_pd_ip     = $first[discovery_public_ip][value]
  apply($target) {
    host { $pmaster:
      ensure         => present,
      name           => $pmaster,
      host_aliases   => ['puppet.ts-aws.tsedemos.com'],
      ip             => $tf_pm_ip,
    }
  }
  apply($target) {
    host { $disco:
      ensure         => present,
      name           => $disco,
      host_aliases   => ['discovery.ts-aws.tsedemos.com'],
      ip             => $tf_pd_ip,
    }
  }
}
