class profile::platform::baseline::windows::packages {

  Package {
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'notepadplusplus': }
  package { 'chocolatey': }
  package { '7zip': }
  package { 'git': }
  package { 'uniextract': }

}
