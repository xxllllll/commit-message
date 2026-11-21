#!/bin/sh
# 装 hook：脚本留在 skill 里，~/.githooks 只放软链，skill 搬家只改软链。
set -eu
here=$(cd "$(dirname "$0")" && pwd)
gh="$HOME/.githooks"
mkdir -p "$gh"
chmod +x "$here/commit-msg" "$here/prepare-commit-msg" "$here/pre-commit"
for h in commit-msg prepare-commit-msg pre-commit; do
  ln -sf "$here/$h" "$gh/$h"
done
git config --global core.hooksPath "$gh"
printf '✓ %s -> %s\n✓ core.hooksPath=%s\n' "$gh" "$here" "$gh"
