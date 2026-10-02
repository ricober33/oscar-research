# OSCAR Research

An agent skill for researching a company, product, person, or market — and finding out what actually made it work, what you can learn from it, and what you cannot copy.

[中文说明](README.md) · [Example report (Chinese)](examples/delphi-ai.md) · [Report template](references/report-template.md)

## What it does

Ask your agent "research X" and it follows five fixed steps:

| Step | Name | Question |
|---|---|---|
| O | Objective | What decision is this research for? What does the user currently assume? |
| S | Scope | How deep? What is must-read, nice-to-have, out of scope? |
| C | Comparison list | Who else to compare: direct peers, different approaches, borrowable ideas, and at least one **failed** attempt |
| A | Evidence | Primary pages → real user behavior → counter-evidence search → archived older versions → original documents → record what could not be opened |
| R | Attribution | What really made it succeed (or fail)? What can be learned, what cannot be copied, what is the single biggest risk? |

Every report has a fixed structure, leads with the conclusion, and must include a section of **things you probably did not see** — 2 to 4 findings that are not visible from the official website and would change your decision. Every important sentence carries a source number and one of five reliability labels (verified / single source / self-reported / interested party / unverified).

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
