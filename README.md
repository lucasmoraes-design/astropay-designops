# AstroPay Design Ops, powered by Claude

A working memory for an AI marketing studio. Connect this repo to Claude and you get a team of specialist agents that produce paid media creatives, in-app banners, and lifecycle emails on AstroPay's actual brand, library, and rules. No prompt-engineering each time, no copy-pasting style guides into every chat.

## What you get

* **A team of named agents.** `@cd` (creative director), `@copy` (copywriter), `@guardian` (brand QA), `@legal-copy` (compliance), plus channel specialists like `@email-subject`, `@email-lifecycle`, `@inapp-nudge`, `@paid-social`. Each has a defined job, character limits, forbidden words, and decision rules.
* **A live mirror of the design system.** Component node IDs, image library, brand tokens, and Figma variables sit in JSON. Agents read from these files and compose creatives directly in Figma via the MCP plugin API.
* **Hard rules baked in.** FSA1399 disclaimer auto-triggers on FX content, footer language matches market, em-dashes get rejected, mobile fold gets checked, master placeholders must be overridden before ship. The agent fails noisy when something is off, instead of shipping silent mistakes.
* **A pipeline.** `@all` for paid media, `@inapp-all` for in-app, `@email-all` for email. Each runs every relevant agent in order: brief in, ready-to-launch creative out.

## Repo layout

```
astropay-designops/
├── CLAUDE.md                       Auto-loaded system prompt
├── BRAND.md                        Voice, products, active campaigns, CTAs, FSA1399 exact text
├── AGENTS-SHARED.md                Cross-channel agents (@cd, @copy, @guardian, @legal-copy)
├── PAID-MEDIA-AGENTS.md            Paid media specialists + Figma production rules
├── INAPP-AGENTS.md                 In-app specialists + Braze in-app rules
├── EMAIL-AGENTS.md                 Email specialists + lifecycle, deliverability, analytics
├── tokens/
│   └── brand.json                  Colors, typography, email channel tokens
├── figma/
│   ├── components.json             Semantic Figma node IDs (paid media, in-app, email)
│   └── images.json                 Image library (6 categories, currency-pair routing, FX rules)
├── .github/workflows/
│   └── design-system-pr.yml        Daily auto-sync from Figma to repo via PR
└── setup.sh                        Local bootstrap script
```

## Connecting this repo to Claude

Two paths depending on how you use Claude.

### Option A: Claude.ai (web, Projects with GitHub)

Best for marketing, copy, brand work. No local setup needed.

1. Sign in at [claude.ai](https://claude.ai) and create a new **Project**.
2. In the project sidebar, click **Add content** then **Connect GitHub**. Authorize Claude to read your repos.
3. Add this repo (`lucasmoraes-design/astropay-designops`). Claude will index the files.
4. In the Project's **Custom instructions**, paste this:
   ```
   Read CLAUDE.md as your system prompt. All agent definitions, brand rules, and library references live in this repo. Always consult the files before answering on brand, copy, or production questions.
   ```
5. Start a conversation. Try: `@email-subject 2 subject lines for a cashback urgency reminder, BR market`.

### Option B: Claude Code (terminal, local repo)

Best for design ops, anyone touching Figma via the MCP plugin, or running the full pipelines.

1. Install Claude Code from [claude.com/claude-code](https://claude.com/claude-code).
2. Clone the repo:
   ```
   git clone https://github.com/lucasmoraes-design/astropay-designops.git
   cd astropay-designops
   ```
3. Run the bootstrap script:
   ```
   ./setup.sh
   ```
4. Open Claude Code in the repo directory:
   ```
   claude
   ```
   Claude Code auto-loads `CLAUDE.md` as the system prompt.
5. To enable Figma read/write via MCP, configure the Figma MCP server in Claude Code settings (one-time). After that, agents like `@cd` can compose directly in your Figma file.

### Option C: API or Claude Agent SDK

Treat the repo as a knowledge base loaded into your custom agent. Read `CLAUDE.md` as the system prompt, and load the other markdown and JSON files as context when their domain matches the user's request. The structure is intentionally split (BRAND, AGENTS-SHARED, channel-specific) so you can lazy-load only what's needed.

## Day-to-day usage

Tags activate agents. Mix and match.

```
@email-all              Produce a full lifecycle email from a brief
@cd compose this welcome email for AR users
@email-subject          2 subject + preheader pairs for a KYC reminder
@guardian QA this 4:5 paid social frame before approval
@inapp-nudge            Trigger logic and 2 variants for a re-engagement banner
@email-deliverability   Pre-launch authentication + reputation check
```

Channel aliases route shared agents into the right context: `@email-copy` is `@copy` with channel pre-set to email. Same for `@inapp-guardian`, `@email-legal`, etc.

## Keeping the repo in sync with Figma

* **Component node IDs and image library**: synced automatically by the `design-system-pr.yml` GitHub Action, daily at 9am UTC. It opens a PR when the Figma file changes. Trigger manually via `workflow_dispatch` if you need a fresh sync now.
* **Color, typography, and channel tokens** (`tokens/brand.json`): update manually when Figma Variables change. Open a PR.
* **Voice, agents, brand rules** (`BRAND.md`, `AGENTS-SHARED.md`, `*-AGENTS.md`): update via PR for any positioning change, tone update, new campaign, or new agent rule.

## Who this is for

* **Design ops**: owns the system, keeps Figma and the repo in sync, refines agent rules over time.
* **Copywriters and brand**: edit `BRAND.md` and `@copy` voice rules. Everything else flows from there.
* **Growth and lifecycle**: write briefs in plain language, run `@email-all` or `@inapp-all`, get production-ready outputs.
* **Engineering**: read `figma/components.json` and `tokens/brand.json` for canonical node IDs and tokens. The repo doubles as a frontend reference.

## Roadmap

* [x] GitHub Action for automatic design system sync via Figma REST API
* [x] Email production pipeline (`@email-all`)
* [ ] Transfer to AstroPay org for company-wide access
* [ ] Auto-validation skill for stale node IDs after Figma renames
* [ ] Multi-language brief intake (write the brief in EN, ES-AR, or PT-BR; agent routes language automatically)
