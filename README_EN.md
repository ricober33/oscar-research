# OSCAR Research

An agent skill for researching a company, product, person, or market — and finding out what actually made it work, what you can learn from it, and what you cannot copy.

[中文说明](README.md) · [Example report (Chinese)](examples/delphi-ai.md) · [Report template](references/report-template.md)

## What it does

Ask your agent "research X". It starts with a canvas of at most 10 lines (what will and will not be researched, who will be compared), then follows five steps:

| Step | Name | Question |
|---|---|---|
| O | Objective | Turn "tell me about X" into a decision question: options, success criteria, out of scope |
| S | Sufficient scope | Pick one of seven depth levels (SOP, ROI, revenue formula, unit economics, business model, whole company, industry); must-read / optional / out |
| C | Clear comparison set | Direct competitors, indirect competitors, borrowable ideas, and at least one **failed** attempt; no major player missed |
| A | All channels | Official pages → archived older versions → real user behavior → counter-evidence search → job posts → reports → regulation → original documents |
| R | Reality first | Ask "why" until reaching the structural cause; then answer the decision question, give ≤3 key judgments, the strongest counter-evidence, gaps and a two-week test |

Every report has a fixed structure, leads with the conclusion, and must include a section of **things you probably did not see** — 2 to 4 findings that are not visible from the official website and would change your decision. Every important sentence carries a source number and one of five reliability labels (verified / single source / self-reported / interested party / unverified).

## Researching a person, and protecting your accounts

Researching a teacher, creator, or personal account follows its own method (`references/person-research.md`): pull the data of their posts, compare what performed well against what did not, break down covers, titles and pages with real examples, then sort what you can take into four groups.

Platforms such as Xiaohongshu and Douyin ban accounts that read in bulk. By default the skill does not read these platforms with your logged-in account; it uses public pages, screenshots you send, or third-party data first, asks before using your login, caps pages and spacing, and stops at the first sign of rate limiting (`references/account-safety.md`).

## Install

```bash
git clone https://github.com/ricober33/oscar-research.git ~/.agents/skills/oscar-research
bash ~/.agents/skills/oscar-research/scripts/install.sh   # links into Claude Code, Codex, Zcode, Cursor, Antigravity
bash ~/.agents/skills/oscar-research/scripts/check.sh     # confirms every client reads the same file
```

For web-based assistants (Grok, ChatGPT, Gemini), run `scripts/build-single-file.sh` and paste the generated `dist/oscar-research-单文件版.md` into the custom instructions.

Optional: copy `my-context.example.md` to `my-context.md` and describe your own work, market, and writing preferences. It stays local (git-ignored).

## Language

The skill and reports are written in Simplified Chinese. The agent replies in the language you ask in.

## License

MIT
