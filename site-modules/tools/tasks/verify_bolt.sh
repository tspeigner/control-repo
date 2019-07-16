#!/bin/bash
# A task to validate that Puppet Bolt is up-to-date
# Params
version=$(/opt/puppetlabs/bin/bolt --version)
# Above output is 1.26.0
# Notes on 'cut' - cut -d (delimiter) . (period is the delimter) -f (field) 1 (field to cut from others)
major=`echo $version | cut -d. -f1`
minor=`echo $version | cut -d. -f2`
revision=`echo $version | cut -d. -f3`

if [ $major -ge 1 ] && [ $minor -ge 16 ]; then
    exit 0
else
    exit 1
fi