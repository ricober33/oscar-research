#!/usr/bin/env bash
# 给读不了本机文件夹的 AI（Grok、ChatGPT 自定义 GPT、Gemini Gem 等）生成一个单文件版本。
# 内容 = 个人背景（如果有）+ SKILL.md + 报告模板，合成一份，整段粘贴即可。
# 生成的文件含个人背景，放在 dist/ 下，不会上传 GitHub。
#
# 用法：bash scripts/build-single-file.sh
set -euo pipefail

SRC="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="$SRC/dist"
OUT="$OUT_DIR/oscar-research-单文件版.md"
mkdir -p "$OUT_DIR"

{
  echo "以下是一份调研 skill 的完整说明。之后用户说调研、研究、拆解、OSCAR、看看这家公司、竞品、学标杆、盯对手时，严格按这份说明做。"
  echo "说明里提到的 my-context.md 和 references/report-template.md，内容都已经附在本文里。"
  echo
  if [ -f "$SRC/my-context.md" ]; then
    echo "==================== my-context.md ===================="
    echo
    cat "$SRC/my-context.md"
    echo
  fi
  echo "==================== SKILL.md ===================="
  echo
  # 去掉开头的 --- 元信息块
  awk 'BEGIN{n=0} /^---[[:space:]]*$/ && n<2 {n++; next} n>=2 {print}' "$SRC/SKILL.md"
  echo
  echo "==================== references/report-template.md ===================="
  echo
  cat "$SRC/references/report-template.md"
} > "$OUT"

echo "已生成：$OUT"
echo "字数：$(wc -m < "$OUT" | tr -d ' ')"
