class profile::platform::baseline::windows::common {

  reboot{'dsc_reboot':
    when    => pending,
    timeout => 15,
  }
  windows_env {'tommy-test':
      ensure    => present,
      variable  => 'AWS Secret',
      value     => 'ASDSAJHFKSHAWA8',
      mergemode => clobber,
  }

}
