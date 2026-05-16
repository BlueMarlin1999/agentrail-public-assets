# Claude Review Brief: AgentRail Public Site

Date: 2026-05-17  
Repo: https://github.com/BlueMarlin1999/agentrail-public-assets  
Live site: https://www.agentrail.tech/  
Branch: `main`

## Current Intent

AgentRail is currently positioned for personal/internal self-use, not commercialization.

The public website should act as:

- A stable install entry for the AgentRail Hermes skill.
- A release/download hub for the current beta package.
- A self-use SOP page showing how to check and update `agentrail.tech`.
- A domain guide for keeping `www.agentrail.tech` as the canonical public host.

## Main Files To Review

- `docs/index.html`
- `docs/pricing.html`
- `docs/agentrail-install.html`
- `docs/release.html`
- `docs/root-domain-redirect.html`
- `install-online.sh`

## Verification Already Run

Live HTTP checks:

```bash
curl -sS -o /dev/null -w "%{http_code} /\n" https://www.agentrail.tech/
curl -sS -o /dev/null -w "%{http_code} /pricing.html\n" https://www.agentrail.tech/pricing.html
curl -sS -o /dev/null -w "%{http_code} /agentrail-install.html\n" https://www.agentrail.tech/agentrail-install.html
curl -sS -o /dev/null -w "%{http_code} /release.html\n" https://www.agentrail.tech/release.html
curl -sS -o /dev/null -w "%{http_code} /root-domain-redirect.html\n" https://www.agentrail.tech/root-domain-redirect.html
```

Result: all returned `200`.

Old commercial-positioning keyword check:

```bash
rg -n "View Pricing|Beta Early Access|Commercial Pricing|查看价格|价格页|商业入口|商业定价|可销售|data-lang=\"ja\"" docs/*.html
```

Result: no matches.

Real installer smoke test:

```bash
curl -fsSL https://www.agentrail.tech/install-online.sh -o /private/tmp/agentrail-install-online.sh
env HOME=/private/tmp/agentrail-install-smoke bash /private/tmp/agentrail-install-online.sh smoke-profile
```

Result: install completed into a temporary Hermes profile without touching the user's real `~/.hermes`.

Installed path:

```text
/private/tmp/agentrail-install-smoke/.hermes/profiles/smoke-profile/skills/software-development/agentrail
```

Observed payload: `SKILL.md` plus 12 files under `references/`.

## Claude Code Review Focus

- Check whether the static HTML pages have duplicated inline CSS/JS that should remain as-is for simplicity or be consolidated.
- Review `install-online.sh` for shell safety, failure behavior, and whether `rm -rf "$DEST_DIR"` is acceptable for an installer that overwrites a profile skill.
- Confirm links, release URLs, and the `www.agentrail.tech` canonical flow are consistent.
- Check accessibility basics: headings, contrast, focus states, button/link semantics, and mobile readability.
- Review whether the self-use positioning is consistent across all entry pages.

## Claude Design Review Focus

- Review whether the visual system feels appropriate for a personal operational tool rather than a commercial SaaS landing page.
- Check hierarchy on the home page: hero, install/release/self-use paths, AgentRail value explanation, and status cards.
- Check whether the color palette, AR logo, and theme controls feel coherent across pages.
- Review mobile layout and text density.
- Check whether the self-use SOP page is clear enough for repeated personal use.

## Known Follow-up Risk

During the live smoke test, AgentRail's separate `perpetual-engine` workflow exposed a queue-state issue: a stale duplicate `IMPLEMENTATION_COMPLETED` event can remain pending and cause an invalid `SELF_CHECK -> SELF_CHECK` transition. That is not in this website repo, but it should be reviewed later in:

```text
/Users/marlins/hermes-webui/perpetual-engine
```

The website repo is clean and ready for review.
