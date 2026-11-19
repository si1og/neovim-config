#!/bin/sh

set -eu

payload_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
export GIT_EXEC_PATH="$payload_dir/opt/git/libexec/git-core"
export LD_LIBRARY_PATH="$payload_dir/opt/git/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
exec "$payload_dir/opt/git/bin/git" "$@"
