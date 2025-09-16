#!/bin/sh

# Workaround for shared certificates for forgejo.xvm domain
if [ "${1:-forgejo.xvm}" = "forgejo.xvm" ]; then
	apt-mark hold ca-certificates
	apt-get install -y equivs

	cd /tmp
	# Create and build a dummy ca-certificates package
	cat > ca-certificates-dummy << 'EOF'
Section: misc
Priority: optional
Standards-Version: 3.9.2

Package: ca-certificates
Provides: ca-certificates-java
Version: 1:20250419
Maintainer: Dummy Package <dummy@example.com>
Architecture: all
Description: Dummy ca-certificates package to satisfy dependencies
 This is a dummy package to mark ca-certificates as installed.
EOF
	equivs-build ca-certificates-dummy
	dpkg -i ca-certificates*.deb
	cd -
fi
