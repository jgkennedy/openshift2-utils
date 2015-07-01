#!/bin/sh

#
# Create one app and stop it
#
# assumes domain namespace == username
# also assumes friendly hostname symlinks in /var/lib/openshift (i.e., devenv mode)
#

if [ \! -d /var/lib/openshift/${2}-${1} ]; then
  htpasswd -b /etc/openshift/htpasswd "$1" redhat
  curl -X POST -k -u $1:redhat -H "Content-Type: application/json" -d '{ "name": "'$2'", "cartridges": ["diy-0.1"], "domain_id": "'$1'", "application": { "name": "'$2'" } }' https://broker.hosts.example.com/broker/rest/applications
  #curl -X POST -k -u $1:pass -H "Content-Type: application/json" -d '{ "event": "stop", "domain_id": "'$1'", "application_id": "'$2'", "app_event": { "event": "stop" } }' https://localhost/broker/rest/application/$2/events
fi
