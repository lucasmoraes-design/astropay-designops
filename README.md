# AstroPay Design Operations — Marketing AI

Centralized knowledge base for AstroPay's Marketing AI. This repository is the source of truth for paid media creative production, email marketing, and design system operations via Claude.

---

## Structure

```
astropay-designops/
├── CLAUDE.md                       <- System prompt (auto-loaded by Claude)
├── BRAND.md                        <- Voice, tone, products, campaigns, CTAs, disclaimers
├── PAID-MEDIA-AGENTS.md            <- Paid media agents + Figma production rules
├── EMAIL-AGENTS.md                 <- Email agents + Braze configuration
├── tokens/
│   └── brand.json                  <- Color and typography tokens
├── figma/
│   ├── components.json             <- Semantic Figma node IDs
│   └── images.json                 <- Image library (categories, node IDs, usage rules)
├── .github/
│   └── workflows/
│       └── design-system-pr.yml    <- Daily auto-sync from Figma to repo via PR
└── setup.sh                        <- Local bootstrap script
```

---

## How to use with Claude

1. Open a new Project in Claude
2. Connect this repository via GitHub MCP
3. Claude will read CLAUDE.md as the automatic system prompt
4. Start prompting — agents activate by tag or automatically

Examples:
```
"@all create exchange campaign for AR and BR, all formats"
"@email-all re-engagement flow for inactive Infinite users"
"@guardian review this copy before approval"
```

---

## Updating the design system

**Color and typography tokens** (`tokens/brand.json`): update manually when Figma Variables change. Open a PR with a description of the change.

**Component node IDs** (`figma/components.json`) and **image library** (`figma/images.json`): kept in sync automatically by the `design-system-pr.yml` workflow, which runs daily at 9am UTC and opens a PR when the Figma file changes. Can also be triggered manually via `workflow_dispatch`.

**Voice and agents** (`BRAND.md`, `*-AGENTS.md`): update via PR for any positioning change, tone update, or new campaign.

---

## Roadmap

- [x] GitHub Actions for automatic design system sync via Figma REST API
- [ ] Transfer to AstroPay organization when ready for company-wide access
- [ ] Add automatic node ID validation skill
