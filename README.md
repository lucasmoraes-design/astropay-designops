# AstroPay Design Ops, powered by Claude

Connect this repo to Claude and you give the AI a complete, structured memory of how AstroPay's marketing actually works. From that point on, Claude can produce paid ads, in-app banners, and lifecycle emails that follow the brand voice, the legal rules, the design system, and the campaign positioning, without anyone copy-pasting style guides into a chat each time.

## The problem this solves

Every AstroPay creative has to obey a stack of rules at once:

* Brand voice (Core vs Infinite, voseo for AR, colloquial for BR, EN as fallback)
* Legal disclaimer (FSA1399 verbatim on any FX content)
* Design system (which Figma component, which photo from the library, which footer per market)
* Channel mechanics (Apple Mail iOS truncates subjects at 30 chars, Gmail mobile fold is at 568px, Braze frequency cap is 3 marketing emails per user per week)
* Deliverability (SPF, DKIM, DMARC, sender reputation, spam complaint rate)

A human can hold all of this for the first 2 emails of a campaign. By the 10th email, somebody forgets a rule and a creative ships with a wrong CTA, a missing disclaimer, or a footer in the wrong language. The repo encodes every rule as a file Claude reads, so the rules apply automatically and consistently to every brief.

## What's inside

A team of specialized AI assistants (we call them agents) plus the brand and design system knowledge they need. Think of it as a kitchen brigade: there are generalists who run the menu (`@cd` creative direction, `@copy` writing, `@guardian` brand QA, `@legal-copy` compliance), and there are specialists who only do one thing extremely well (`@email-subject` only writes subject lines, `@email-deliverability` only handles SPF/DKIM/DMARC).

You write a brief in plain language. Claude calls each relevant agent in order. A ready-to-ship creative comes out the other side, in Figma if visual or as text if a subject line / preheader / Liquid block.

## Email Marketing operation

Email is the most developed channel in this repo as of 2026-05-08. Worth a deeper section because it shows what the system can do end-to-end.

### The 10 agents involved in email production

**Cross-channel (work for paid media and in-app too):**

* `@cd` composes the email visually in Figma. Picks the hero variant, the body blocks, the footer language, the photo or illustration. Applies the Header Section pattern, runs H1 auto-fit, and refreshes the canvas after edits.
* `@copy` (alias `@email-copy`) writes the body. Knows AstroPay voice rules per market, character limits per element, forbidden words, and which CTA to use per campaign.
* `@guardian` (alias `@email-guardian`) is the final approver. Catches forbidden words, em-dashes (signals AI), leftover placeholders, mobile fold violations, and footer language mismatches.
* `@legal-copy` (alias `@email-legal`) verifies FSA1399 inclusion, LGPD and CAN-SPAM compliance, transactional vs marketing classification.

**Email-only specialists:**

* `@email-subject` writes subject lines and preheaders. Knows that Apple Mail iOS truncates around 30 chars, that ALL CAPS triggers spam filters, that "Re:" or "[Action required]" on first-touch marketing is a CAN-SPAM violation.
* `@email-lifecycle` designs journeys. Takes a behavioral trigger ("user inactive 30 days", "first FX completed", "KYC pending 48h") and maps the sequence: how many emails, what gap between them, what message at each stage, what user-local send time.
* `@email-experiment` designs A/B tests. Picks the single variable to test, the primary metric, and the kill condition (e.g., abort if spam complaint rate exceeds 0.1%).
* `@email-dist` is the Braze distribution router. Matches market to footer language, enforces the weekly frequency cap, suppresses unsubscribed users, audits Liquid coverage.
* `@email-deliverability` is the technical hygiene layer. Without it, all the work above lands in spam.
* `@email-analytics` reads the post-launch numbers (open rate, click-through, conversion, unsubscribe, spam complaints) and recommends what to test next.

### The pipeline `@email-all`

```
Brief
  > @email-lifecycle      designs the journey and the trigger
  > @email-subject        produces 2 subject + preheader pairs
  > @email-copy           produces 2 body variants
  > @cd                   composes the email visually in Figma
  > @email-guardian       brand QA, voice, contrast, dark mode, placeholder check
  > @email-legal          FSA1399, LGPD, cobrand legal
  > @email-experiment     defines the A/B with deliverability guardrails
  > @email-dist           routes by market, applies frequency caps
  > @email-deliverability confirms authentication and reputation
  > LAUNCH
  > @email-analytics      post-launch report, recommendation feeds back to the top
```

### Email-specific rules the system enforces

This is what makes the email output feel intentional rather than auto-generated:

* **Composition rhythm**: in multi-block emails, alternate visual texture (text-only, image-led, grid). Never 3+ identical blocks in a row.
* **Illustration ↔ journey phase**: the 8 illustration use cases are mapped to the 6 BRAND.md journey phases. `astronaut` is for Memorable intro, `completed` for Success, `kyc` for Support. Hard mismatches (e.g., `spin` in a Support email) get blocked.
* **Mobile fold check**: hero H1 must land above the 568px Gmail iOS fold (~448px after the menu).
* **Loop close**: subject promise + hero illustration + first H1 must reinforce the same value claim. If the subject says "Two days left" but the H1 says "Welcome", the agent flags the broken loop.
* **Phrase highlight**: ONE highlighted phrase per email, in the `Teal 2025 > over Light` token (#00c5ac), only when the hero is illustration-based. Photographic and dark heroes keep solid color H1 because the photo / dark contrast already carries the visual interest.
* **H1 character budgets**: each hero variant has a documented placeholder length. When brief copy exceeds the budget, the agent splits the message between H1 and subtitle rather than shrinking the font (which would break visual hierarchy).

### A real example

Brief: "Lifecycle email for users who completed their first FX 3 days ago. Educate on repeating the conversion. EN, no urgency, no Infinite mention."

Output from `@email-all`:

* Subject A: "Your next exchange is one tap away" / Preheader: "Same rate, every time."
* Hero: `soft_teal_illustration` with `illustrations.exchange` swapped in
* Hero H1: "Make your second exchange in under a minute" with "under a minute" highlighted in teal
* Body block: educational paragraph about the repeat path, CTA "Convert now"
* Feature grid: 4 reassurance cards (1-tap convert, Locked-in rate, No hidden fees, Full FX history)
* Footer: `footers.en` with FSA1399 EN exact text manually injected (master placeholder is English boilerplate, design system bug pending fix)
* QA: brand voice within EN rules, no em-dashes, no forbidden words, footer language matches segment, fold check passes, loop close confirmed

Time from brief to ready-for-Braze: minutes, not days.

## Repo layout

```
astropay-designops/
├── CLAUDE.md                       Auto-loaded system prompt (entry point)
├── BRAND.md                        Voice, products, active campaigns, CTAs, FSA1399 exact text
├── AGENTS-SHARED.md                Cross-channel agents (@cd, @copy, @guardian, @legal-copy)
├── PAID-MEDIA-AGENTS.md            Paid media specialists + Figma production rules
├── INAPP-AGENTS.md                 In-app specialists + Braze in-app rules
├── EMAIL-AGENTS.md                 Email specialists (subject, lifecycle, experiment, dist, deliverability, analytics)
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

Three paths depending on how you use Claude.

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

### Option C: API or Claude Agent SDK

Treat the repo as a knowledge base loaded into your custom agent. Read `CLAUDE.md` as the system prompt and lazy-load the other files when their domain matches the user's request. The structure is intentionally split (BRAND, AGENTS-SHARED, channel-specific) so you can load only what's needed.

## Day-to-day prompts

```
@email-all                Produce a full lifecycle email from a brief
@cd compose this welcome email for AR users
@email-subject            2 subject + preheader pairs for a KYC reminder
@email-lifecycle          Map the journey for re-engaging 30-day inactives
@email-experiment         A/B test plan for the new cashback offer
@inapp-nudge              Trigger logic and 2 variants for an in-app banner
@guardian QA this 4:5 paid social frame before approval
@email-deliverability     Pre-launch authentication + reputation check
```

Channel aliases route shared agents into the right context: `@email-copy` is `@copy` with channel pre-set to email. Same for `@inapp-guardian`, `@email-legal`, etc.

## Who this is for

* **Design ops**: owns the system, keeps Figma and the repo in sync, refines agent rules over time.
* **Copywriters and brand**: edit `BRAND.md` and `@copy` voice rules. Everything else flows from there.
* **Growth and lifecycle**: write briefs in plain language, run `@email-all` or `@inapp-all`, get production-ready outputs.
* **Engineering**: read `figma/components.json` and `tokens/brand.json` for canonical node IDs and tokens. The repo doubles as a frontend reference.

## FAQ

**Does this replace designers, copywriters, or brand managers?**
No. The agents handle the rule-following and the production grunt work (override placeholders, swap photos, check fold, validate disclaimers, route by market). Strategic decisions, taste calls, and edge cases still need human review. `@guardian` is the gate, but a human signs off on the brand impact of a new positioning. Treat the system as a junior production team that never forgets a rule.

**Does Claude have access to AstroPay's customer data?**
No. The repo contains brand rules, design system references, and journey logic. No customer PII, no segment exports, no real send logs. When the agents reference "the user", they mean the abstract recipient defined by the brief, not a real person.

**What if a rule changes?**
Edit the matching markdown file (`BRAND.md` for brand, `AGENTS-SHARED.md` for shared agents, `EMAIL-AGENTS.md` for email specialists), open a PR. From the next conversation onward, every agent picks up the new rule. No retraining, no model updates. The "memory" is the file.

**The Figma file changed. How does the repo catch up?**
Component node IDs and the image library auto-sync via the `design-system-pr.yml` GitHub Action, daily at 9am UTC. It opens a PR when the Figma file changes. You can also trigger it manually via `workflow_dispatch`.

**Why not just use ChatGPT with a long system prompt?**
You can. The repo's value is that the rules are versioned, reviewable via PR, and split into files small enough that any team member can read and edit one section without breaking another. A 50-page system prompt becomes unmaintainable fast; a repo with 8 markdown files stays clean.

**Can the email agents handle AR and BR markets at the same brief?**
Each send goes to one market. The pipeline routes language and disclaimer per market. A campaign that needs both AR and BR sends results in two passes through `@email-all`, one per market, with `@email-dist` keeping the segment separation clean.

**What does the system NOT do?**
* It does not push the final email into Braze. That step is still manual or via a separate Braze integration.
* It does not generate photographs or illustrations. It only picks from the existing image library and illustration set.
* It does not run live A/B tests. `@email-experiment` defines the test plan; the test runs in Braze.
* It does not predict ROI. `@email-analytics` reads post-launch data after the test ends.

## Keeping the repo in sync

* **Component node IDs and image library**: auto-synced daily by the GitHub Action.
* **Color and typography tokens** (`tokens/brand.json`): update manually when Figma Variables change. Open a PR.
* **Voice, agents, brand rules**: update via PR for any positioning change, tone update, new campaign, or new agent rule.

## Roadmap

* [x] GitHub Action for automatic design system sync via Figma REST API
* [x] Email production pipeline (`@email-all`)
* [x] Cross-channel production discipline (placeholder rule, content budget, canvas refresh, photo aspect)
* [ ] Transfer to AstroPay org for company-wide access
* [ ] Auto-validation skill for stale node IDs after Figma renames
* [ ] Multi-language brief intake (write the brief in EN, ES-AR, or PT-BR; agent routes language automatically)
* [ ] Native Braze MCP integration so `@email-dist` can push the final send
* [ ] Performance feedback loop: `@email-analytics` reads Braze numbers and updates the journey design in `EMAIL-AGENTS.md`

---

Maintained by **Lucas Moraes** (Design Ops). Open an issue on GitHub for bugs, requests, or new agent ideas.
