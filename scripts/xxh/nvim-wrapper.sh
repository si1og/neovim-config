#!/bin/sh

set -eu

payload_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
export XDG_CONFIG_HOME="$payload_dir/config"
export NVIM_CONFIG_HS="$payload_dir/bin/nvim-config-hs"
export LD_LIBRARY_PATH="$payload_dir/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
exec "$payload_dir/opt/nvim/bin/nvim" "$@"
