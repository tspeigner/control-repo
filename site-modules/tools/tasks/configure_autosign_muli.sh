#!/bin/bash
# Add entries to Puppet Enterprise autosigning.

entries=("*.classroom.puppet.com" "*.compute.internal")

for e in "${entries[@]}"
do
    echo "$e" >> /etc/puppetlabs/puppet/autosign.conf
done