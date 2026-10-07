#!/usr/bin/env bash
# 把 oscar-research 装到本机所有支持 skill 文件夹的 AI 客户端。
# 做法：每个客户端的 skill 文件夹里放一条指向本仓库的链接。
# 所有客户端读的是同一份文件，改一处，处处生效；git pull 就是更新。
#
# 用法：bash scripts/install.sh
set -euo pipefail

SRC="$(cd "$(dirname "$0")/.." && pwd)"
NAME="oscar-research"
STAMP="$(date +%Y%m%d-%H%M%S)"

# 客户端名称|它的 skill 文件夹|判断客户端是否装了的文件夹
TARGETS=(
  "Claude Code|$HOME/.claude/skills|$HOME/.claude"
  "Codex|$HOME/.codex/skills|$HOME/.codex"
  "共享库（多个客户端共用）|$HOME/.agents/skills|$HOME/.agents"
  "Zcode|$HOME/.zcode/skills|$HOME/.zcode"
  "Cursor|$HOME/.cursor/skills|$HOME/.cursor"
  "Antigravity|$HOME/.gemini/config/skills|$HOME/.gemini"
  "Antigravity CLI|$HOME/.gemini/antigravity-cli/skills|$HOME/.gemini/antigravity-cli"
)

echo "来源：$SRC"
echo

for row in "${TARGETS[@]}"; do
  IFS='|' read -r label dir marker <<<"$row"
  dest="$dir/$NAME"

  if [ ! -d "$marker" ]; then
    printf '  跳过  %-24s 这台电脑上没装这个客户端\n' "$label"
    continue
  fi

  # 仓库本身就放在这个文件夹里，不用再链接
  if [ "$(cd "$dir" 2>/dev/null && pwd -P)/$NAME" = "$(cd "$SRC" && pwd -P)" ]; then
    printf '  已在  %-24s %s\n' "$label" "$dest"
    continue
  fi

  mkdir -p "$dir"

  # 同名的旧文件夹（不是链接）先改名备份，不删除
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dir/_backup-$NAME-$STAMP"
    printf '  备份  %-24s 旧文件夹改名为 _backup-%s-%s\n' "$label" "$NAME" "$STAMP"
  fi

  ln -sfn "$SRC" "$dest"
  printf '  装好  %-24s %s\n' "$label" "$dest"
done

echo
echo "Grokbot 的技能在它的独立运行环境里；本脚本不安装或更新 Grokbot，须核实它实际加载的工作流目录后单独同步。"
echo "Grok、ChatGPT 这类网页里的 AI 读不了本机文件夹："
echo "  运行 bash scripts/build-single-file.sh，把生成的 dist/oscar-research-单文件版.md 整段粘进去。"
echo
echo "检查是否都装好：bash scripts/check.sh"
