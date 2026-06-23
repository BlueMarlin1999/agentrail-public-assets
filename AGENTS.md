# AgentRail Agent Instructions

## Project

AgentRail is a personal-use Beta static website for explaining and operating the AgentRail workflow. The site lives in `docs/` and is served by GitHub Pages at `https://www.agentrail.tech/`.

The product position is not SaaS. Treat it as a personal command rail for dispatching Codex, Claude Code, GitHub Copilot, OpenCode, and similar coding agents while preserving scope, evidence, checks, and a human publish decision.

## Working Rules

- Keep the site static: HTML, CSS, and light inline JavaScript only.
- Do not introduce a framework, build step, bundler, package manager, or shared app runtime.
- Do not extract a common `style.css` or `app.js` unless the human owner explicitly asks for that refactor.
- Preserve existing install commands, release asset URLs, checksums, and GitHub release links unless you verify and update every dependent page.
- Keep `pricing.html` as a compatibility redirect to `self-use.html`.
- Do not touch `docs/CNAME`, `docs/CNAME.example`, `README.md`, `DOMAIN_SETUP.md`, or `CLAUDE_REVIEW_BRIEF.md` unless explicitly instructed.
- Keep the dark, light, and sunset themes working.
- Keep pages mobile responsive and avoid text overflow in nav, cards, buttons, and code blocks.
- Use one semantic `h1` per page and preserve skip navigation.

## Content Standards

- Explain what AgentRail does in plain language before naming internal mechanisms.
- Separate facts from plans. Do not claim live integrations with tools or protocols unless the repo actually ships them.
- Source trend claims with links to official docs or primary project pages.
- Keep the personal Beta boundary visible: no checkout, no pricing table, no customer onboarding language.
- For new roadmap content, name the operator problem solved: dispatch, context retention, review evidence, safety boundary, release control, or recovery.

## Verification

Before publishing, check the changed pages locally and verify the public URLs after deployment:

```bash
curl -sS -o /dev/null -w "%{http_code}\n" \
  https://www.agentrail.tech/ \
  https://www.agentrail.tech/agentrail-install.html \
  https://www.agentrail.tech/release.html \
  https://www.agentrail.tech/agent-stack.html \
  https://www.agentrail.tech/skills.html \
  https://www.agentrail.tech/security.html \
  https://www.agentrail.tech/changelog.html \
  https://www.agentrail.tech/self-use.html \
  https://www.agentrail.tech/root-domain-redirect.html
```

Installer smoke test:

```bash
env HOME=/tmp/agentrail-install-smoke bash docs/install-online.sh smoke-profile
```
