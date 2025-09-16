#!/bin/sh

set -ex

rm -rf .flatpak-builder build-dir
flatpak-builder --install-deps-from=flathub --install --force-clean build-dir org.jackhuang.hmcl.yml
rm -rf .flatpak-builder build-dir
flatpak build-bundle /var/lib/flatpak/repo hmcl.flatpak org.jackhuang.hmcl
flatpak uninstall -y --noninteractive org.jackhuang.hmcl
