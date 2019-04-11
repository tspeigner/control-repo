# This is the the start for each class, this class is a component (NGINX) class
class profile::app::mynginx (
  $full_web_path = '/var/www',
  $app_name      = 'app1',
) {
  #Download and install the NGINX module - https://forge.puppet.com/puppet/nginx
  # This include bootstraps the NGINX instance
  include nginx
  include firewall
  # Simple virtual host 'app1.examplehost.com' with static content '/var/www/app1'
  nginx::resource::server { "${app_name}.examplehost.com":
    listen_port => 8080,
    www_root    => "${full_web_path}/${app_name}",
  }
  # Further example information https://github.com/voxpupuli/puppet-nginx/blob/master/docs/quickstart.md#putting-the-pieces-together
  # Manage firewall (IPTables) - https://forge.puppet.com/puppetlabs/firewall
  firewall { '800 allow app1':
    dport  => [8080],
    proto  => tcp,
    action => accept,
  }
}
