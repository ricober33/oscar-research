#!/usr/bin/env bash
# 发布前的格式检查（GitHub 上每次提交自动跑一遍，本机也可以跑）。
# 用法：bash scripts/lint.sh
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="$ROOT/SKILL.md"
TEMPLATE="$ROOT/references/report-template.md"
fail=0
err() { echo "  ✗ $1"; fail=1; }
pass() { echo "  ✓ $1"; }

echo "检查 SKILL.md"

head -1 "$SKILL" | grep -qx -- '---' && pass "有开头的元信息块" || err "第一行应为 ---"
for key in name version description; do
  grep -qE "^$key:" "$SKILL" && pass "元信息里有 $key" || err "元信息缺 $key"
done
grep -qE '^name: oscar-research$' "$SKILL" && pass "name 是 oscar-research" || err "name 应为 oscar-research"

for h in "## O 目标" "## S 范围" "## C 清单" "## A 查证" "## R 归因" "## 你可能没看到的" "## 存档" "## 交出去之前自查"; do
  grep -qF "$h" "$SKILL" && pass "有小节：$h" || err "缺小节：$h"
done

echo
echo "检查报告模板"
for h in "## 结论" "## 你可能没看到的" "## 钱和人怎么流动" "## 它为什么做成了（或没做成）" "## 拿来比的几家" "## 你能学的，不能照搬的，最大的风险" "## 下一步：一个两周内能做的小验证" "## 还不知道的" "## 来源"; do
  grep -qF "$h" "$TEMPLATE" && pass "模板有：$h" || err "模板缺：$h"
done

echo
echo "检查用词（这些词会让读者看不懂，SKILL.md 和模板里不该出现）"
BANNED='负载步骤|去壳|卷宗|逻辑线|画布|收敛|门禁|判据|赋能|抓手|闭环|护城河|底层逻辑'
if grep -nE "$BANNED" "$SKILL" "$TEMPLATE"; then err "出现了上面这些词"; else pass "没有"; fi

echo
echo "检查不该上传的文件"
cd "$ROOT"
if git ls-files --error-unmatch my-context.md >/dev/null 2>&1; then err "my-context.md 被加进了 git，它含个人信息"; else pass "my-context.md 没有被上传"; fi
if git ls-files | grep -q '^dist/'; then err "dist/ 被加进了 git"; else pass "dist/ 没有被上传"; fi

echo
[ "$fail" -eq 0 ] && echo "全部通过" || echo "有问题，见上面的 ✗"
exit "$fail"
