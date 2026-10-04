#!/usr/bin/env bash
# 检查每个客户端读到的是不是同一份 oscar-research。
# 用法：bash scripts/check.sh
set -uo pipefail

SRC="$(cd "$(dirname "$0")/.." && pwd -P)"
NAME="oscar-research"

hash_of() { shasum -a 256 "$1" 2>/dev/null | cut -c1-12; }
SRC_HASH="$(hash_of "$SRC/SKILL.md")"
VERSION="$(sed -n 's/^ *version: *//p' "$SRC/SKILL.md" | head -1 | tr -d '"')"

echo "仓库：$SRC"
echo "版本：$VERSION   SKILL.md 指纹：$SRC_HASH"
echo

ok=0; bad=0
for row in \
  "Claude Code|$HOME/.claude/skills" \
  "Codex|$HOME/.codex/skills" \
  "共享库|$HOME/.agents/skills" \
  "Zcode|$HOME/.zcode/skills" \
  "Cursor|$HOME/.cursor/skills" \
  "Antigravity|$HOME/.gemini/config/skills" \
  "Antigravity CLI|$HOME/.gemini/antigravity-cli/skills"
do
  IFS='|' read -r label dir <<<"$row"
  dest="$dir/$NAME"
  if [ ! -d "$(dirname "$dir")" ]; then
    printf '  —   %-18s 没装这个客户端\n' "$label"; continue
  fi
  if [ ! -e "$dest" ]; then
    printf '  ✗   %-18s 没装：%s\n' "$label" "$dest"; bad=$((bad+1)); continue
  fi
  real="$(cd "$dest" && pwd -P)"
  h="$(hash_of "$dest/SKILL.md")"
  if [ "$real" = "$SRC" ] && [ "$h" = "$SRC_HASH" ]; then
    printf '  ✓   %-18s 同一份\n' "$label"; ok=$((ok+1))
  else
    printf '  ✗   %-18s 不是同一份（指向 %s，指纹 %s）\n' "$label" "$real" "$h"; bad=$((bad+1))
  fi
done

echo
[ -f "$SRC/my-context.md" ] && echo "个人背景 my-context.md：有" || echo "个人背景 my-context.md：没有（可复制 my-context.example.md 来写）"
echo "结果：$ok 个一致，$bad 个有问题"
[ "$bad" -eq 0 ]
