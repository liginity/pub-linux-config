#!/bin/bash
# get manually installed softwares on Ubuntu, installed by apt
set -veuo pipefail
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
