#!/usr/bin/env ruby
# Add entries to Puppet Enterprise autosigning

entries = ['*.classroom.puppet.com', '*.compute.internal']

File.open('/etc/puppetlabs/puppet/autosign.conf', 'w') do |e|
  entries.each do |en|
    e.write("#{en}\n")
    end
end
