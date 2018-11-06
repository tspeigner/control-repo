#!/bin/sh

cd /Users/tommy/gDrive/code/makevm/terraform-aws-puppet-environment && sudo /usr/local/bin/terraform output -json

#cat <<EOF
#{
#    "discovery_public_ip": {
#        "sensitive": false,
#        "type": "string",
#        "value": "34.222.229.250"
#    },
#    "puppet_master": {
#        "sensitive": false,
#        "type": "string",
#        "value": "52.37.210.242"
#    }
#}
#EOF

