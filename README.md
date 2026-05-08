# AstroPay Design Ops, powered by Claude

Connect this repo to Claude and you give the AI a complete, structured memory of how AstroPay's marketing actually works. From that point on, Claude can produce paid ads, in-app banners, and lifecycle emails that follow the brand voice, the legal rules, the design system, and the campaign positioning, without anyone copy-pasting style guides into a chat each time.

## The problem this solves

Every AstroPay creative has to obey a stack of rules at once: brand voice (Core vs Infinite, voseo for AR, colloquial for BR, EN as fallback), legal disclaimer (FSA1399 verbatim on any FX content), design system (which Figma component, which photo, which footer per market), and channel mechanics (subject truncation, mobile fold, Braze frequency caps, deliverability).

A human can hold all of this for the first 2 creatives of a campaign. By the 10th, somebody forgets a rule and ships with a wrong CTA, a missing disclaimer, or a footer in the wrong language. The repo encodes every rule as a file Claude reads, so the rules apply automatically and consistently to every brief.

## What's inside

A team of specialized AI assistants (agents) plus the brand and design system knowledge they need. Generalists run the menu (`@cd`, `@copy`, `@guardian`, `@legal-copy`); specialists do one thing extremely well. You write a brief in plain language, Claude calls the relevant agents in order, and a ready-to-ship creative comes out — in Figma if visual, as text if a subject line, preheader, or Liquid block.

## Agent teams

Four cross-channel agents and three channel-specific teams, all backed by the shared brand and design system files.

**Cross-channel** (work in any channel, load a channel sub-block when called)
* `@cd` — creative direction, design system, image library QA, Figma composition
* `@copy` — brand voice, headlines, body, CTAs, localization
* `@guardian` — brand compliance, voice QA, final gate
* `@legal-copy` — advertising claims, FSA1399, market-specific compliance

**Paid media** (`@all` runs the full pipeline)
* `@strategist` — ICP, angle, channel mix
* `@paid-social` — Meta and TikTok platform architecture
* `@ad-creative` — RSA, creative testing, ad fatigue
* `@ugc` — short-form video scripts

**In-app banners** (`@inapp-all` runs the full pipeline)
* `@inapp-nudge` — trigger logic, session timing, Braze sequences
* `@inapp-experiment` — A/B test structure
* `@inapp-dist` — segmentation, frequency cap, send orchestration
* `@inapp-analytics` — performance report and recommendations

**Email marketing** (`@email-all` runs the full pipeline)
* `@email-subject` — subject line and preheader
* `@email-lifecycle` — journey design and Braze trigger logic
* `@email-experiment` — A/B test structure
* `@email-dist` — segment routing, language match, frequency cap
* `@email-deliverability` — SPF, DKIM, DMARC, sender reputation
* `@email-analytics` — performance report and recommendations

## Repo layout

```
astropay-designops/
├── CLAUDE.md                       Auto-loaded system prompt (entry point)
├── BRAND.md                        Voice, products, active campaigns, CTAs, FSA1399 exact text
├── AGENTS-SHARED.md                Cross-channel agents (@cd, @copy, @guardian, @legal-copy)
├── PAID-MEDIA-AGENTS.md            Paid media specialists + Figma production rules
├── INAPP-AGENTS.md                 In-app specialists + Braze in-app rules
├── EMAIL-AGENTS.md                 Email specialists + Braze email rules
├── tokens/
│   └── brand.json                  Colors, typography, email-scoped tokens, Figma variable map
├── figma/
│   ├── components.json             Semantic Figma node IDs (paid media, in-app, email)
│   └── images.json                 Image library (6 categories, currency-pair routing, FX rules)
├── .github/workflows/
│   └── design-system-pr.yml        Daily auto-sync from Figma to repo via PR
└── setup.sh                        Local bootstrap script
```

## Connecting this repo to Claude

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
5. To enable Figma read/write via MCP, configure the Figma MCP server in Claude Code settings (one-time). After that, `@cd` can compose directly in your Figma file.

## FAQ

**Does this replace designers, copywriters, or brand managers?**
No. The agents handle the rule-following and the production grunt work (override placeholders, swap photos, check fold, validate disclaimers, route by market). Strategic decisions, taste calls, and edge cases still need human review. `@guardian` is the gate, but a human signs off on the brand impact of a new positioning. Treat the system as a junior production team that never forgets a rule.

**Does Claude have access to AstroPay's customer data?**
No. The repo contains brand rules, design system references, and journey logic. No customer PII, no segment exports, no real send logs. When the agents reference "the user", they mean the abstract recipient defined by the brief.

**What if a rule changes?**
Edit the matching markdown file (`BRAND.md` for brand, `AGENTS-SHARED.md` for shared agents, the channel file for specialists) and open a PR. From the next conversation onward, every agent picks up the new rule. No retraining, no model updates. The "memory" is the file.

**The Figma file changed. How does the repo catch up?**
Component node IDs and the image library auto-sync via the `design-system-pr.yml` GitHub Action, daily at 9am UTC. It opens a PR when the Figma file changes. You can also trigger it manually via `workflow_dispatch`.

**Why not just use ChatGPT with a long system prompt?**
You can. The repo's value is that the rules are versioned, reviewable via PR, and split into files small enough that any team member can read and edit one section without breaking another.

**Can the agents handle AR and BR markets in the same brief?**
Each send goes to one market. The pipeline routes language and disclaimer per market. A campaign that needs both results in two passes, one per market.

**What does the system NOT do?**
It does not push the final creative into Braze or the ad platforms (still manual or via separate integrations), generate photos or illustrations (only picks from the library), run live A/B tests (the experiment agents define plans; tests run in Braze or the ad platforms), or predict ROI (analytics agents read post-launch data).

## Keeping the repo in sync

* **Component node IDs and image library**: auto-synced daily by the GitHub Action.
* **Color and typography tokens** (`tokens/brand.json`): update manually when Figma Variables change. Open a PR.
* **Voice, agents, brand rules**: update via PR for any positioning change, tone update, new campaign, or new agent rule.

## Roadmap

* [x] Daily Figma → repo sync via GitHub Action
* [x] Full pipelines for paid media, in-app, and email
* [ ] Transfer to AstroPay org for company-wide access
* [ ] Multi-language brief intake (EN, ES-AR, PT-BR)
* [ ] Native Braze MCP integration for direct send
* [ ] Performance feedback loop from analytics back into agent rules

---

Maintained by **Lucas Moraes** (Design Ops). Open an issue on GitHub for bugs, requests, or new agent ideas.
