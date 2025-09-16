#!/bin/sh

# Workaround for shared certificates for forgejo.xvm domain
if [ "${1:-forgejo.xvm}" = "forgejo.xvm" ]; then
	mkdir -p /var/lib/dpkg/info/
	touch /var/lib/dpkg/info/ca-certificates.list
	touch /var/lib/dpkg/info/ca-certificates-java.list
	echo "ca-certificates install" | dpkg --set-selections
	echo "ca-certificates-java install" | dpkg --set-selections
fi
