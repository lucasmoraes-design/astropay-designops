# AstroPay — Brand Foundation
> Root file. Loaded by all agents across all domains.
> Never duplicate this content in other files — always reference.

---

## 1. BRAND IDENTITY

**Mission**: Simplify how people and businesses move money — a lifestyle enabler, not just a financial service.

**Voice**: Clear, transparent, fun, approachable. Global yet localized — always feel native to the market. Direct, punchy, no jargon, no corporate filler. Short, active sentences.

### Tone by customer journey phase
| Phase | Tone | Touchpoints |
|---|---|---|
| Memorable introduction | Curious, exciting, simple | Onboarding, emails, in-app |
| Consideration | Trust-building, clear | Product pages, App Store, campaigns |
| Education | Informative, confident | Onboarding, in-app flows |
| Use | Focused, guiding | In-app, campaigns |
| Engagement | Inspiring, delightful | Social, lifecycle, events |
| Support | Empathetic, fast, clear | Chatbot, error states |
| Success | Celebratory, warm | Success screens, confirmation emails |

### Language
**Works**: Descubrí, Conocé, Aprovechá, Rápido, Simple, Directo, Sin vueltas, Como un local, En un toque

**Never use**: Experimente, Solución financiera, Liberdade financeira, Innovador, Ecosistema, Poderoso, Revolucionário, Seamless, Unlock, Empowering, Game-changer, Next-level, Cutting-edge

---

## 2. PRODUCTS

### AstroPay (core)
Global payments, accessible, lifestyle-enabling. Sends money, pays abroad, currency exchange, freelance accounts, PIX for Argentinians in Brazil.
- **Tone**: fun, approachable, simple
- **Lead with**: the feeling — freedom, simplicity, being local anywhere

### AstroPay Infinite
Premium membership — **"La membresía que se paga sola."**
- Must be perceived as separate from core AstroPay — never mix
- Justifies price ($X/month) and converts free → paid
- Personality: Ingenious, Direct, Aspirational, Tangible, Reliable
- **Lead with**: ROI, measurable value, benefits before features, specific numbers
- **Tone**: premium without pretense, confident but never arrogant

**Absolute rule: never mix Infinite copy with core AstroPay visuals (or vice versa) in the same creative or email.**

---

## 3. ACTIVE CAMPAIGNS

### PIX — Argentinians Travelling to Brazil
- Angle: "Pagar en Brasil como un local"
- Winning hooks: "Para los argentinos, es más fácil" / "De turista a local en 1 pago" / "PIX con QR"
- CTA: "Usá Pix en Brasil"
- Language: ES-AR | Image: Traveler

### Currency Exchange — Performance
- Angle: "Control total de tu cambio"
- Winning hooks: "¿Nunca sabés el monto final cuando cambiás moneda?" / "Cambiar moneda no debería ser confuso"
- CTA: "Convertir ahora" (ES-AR) / "Converter agora" (PT-BR)
- ⚠️ Regulatory disclaimer required (FSA1399)

### Currency Exchange — Awareness
- Same product, upper-funnel. Pain-first, doubt-based framing.

### Freelance SMB
- Angle: "Una cuenta distinta para tu trabajo freelance"
- Hooks: "¿Trabajás como freelancer?" / "Una cuenta para freelancers"
- CTA: "Crea tu cuenta AstroPay"
- Language: ES-AR | Image: Freelancer or Digital Nomad

### AstroPay Infinite — GTM Argentina
- Brand promise: "La membresía que se paga sola"
- Angle: ROI measurable, premium without pretense
- Goal: convert free users to paid membership

---

## 4. CTAs BY CAMPAIGN

| Action | PT-BR | ES-AR |
|---|---|---|
| Currency exchange | Converter agora | Convertir ahora |
| Account signup | Criar conta | Crea tu cuenta |
| Freelance signup | Criar conta freelance | Crear cuenta freelance |
| PIX | — | Usá Pix en Brasil |
| Infinite upsell | Quero o Infinite | Quiero el Infinite |

**Language rule**: frames/emails with `AR-` in name → ES-AR. All others → PT-BR.

---

## 5. REGULATORY DISCLAIMER (FSA1399)

Required in any content that mentions: currency exchange, FX rates, money transfer, conversion, exchange rates, or any financial returns or rates.

**PT-BR** (exact text — never paraphrase):
`AstroPay Global (IOM) Limited (135497C), autorizada e regulada pela Autoridade de Serviços Financeiros da Ilha de Man como titular de uma licença de Classe 8(2)(a) e (4) para prestar serviços de transmissão de dinheiro. Licença N.º FSA1399. Aplicam-se termos e condições. Visite astropay.com para mais detalhes.`

**ES-AR** (exact text — never paraphrase):
`AstroPay Global (IOM) Limited (135497C), autorizada y regulada por la Isle of Man Financial Services Authority como titular de una licencia de Clase 8(2)(a) y (4) para prestar servicios de transmisión de dinero. Licencia N.º FSA1399. Aplican términos y condiciones. Visita astropay.com para más detalles.`

---

## 6. DESIGN TOKENS

```js
const BRAND = {
  teal500:     { r:0.255, g:0.871, b:0.792 }, // #42DECA — primary accent / CTA
  teal900:     { r:0.090, g:0.298, b:0.271 }, // #174C45 — dark bg
  teal1000:    { r:0.067, g:0.220, b:0.200 }, // #113833 — darker teal
  neutral1300: { r:0.059, g:0.082, b:0.078 }, // #0F1514 — darkest bg
  neutral1200: { r:0.098, g:0.129, b:0.125 }, // #192120
  neutral1100: { r:0.133, g:0.173, b:0.169 }, // #222C2B
  muted:       { r:0.588, g:0.639, b:0.631 }, // #96A3A1
  white:       { r:1,     g:1,     b:1     },
  baseBlack:   { r:0.082, g:0.118, b:0.114 }, // #151E1D
};
```

**Typography**: `Matter` (primary) — styles: `Regular`, `Medium`, `SemiBold`, `Bold`.
Fallback: `Inter` — note `"Semi Bold"` with a space (not `"SemiBold"`).

---

## 7. LANGUAGE RULES

**ES-AR native**: voseo consistent throughout — Aprovechá, Conocé, Descubrí, Usá. Never tuteo. Never "usted."

**PT-BR native**: colloquial register, direct, warm. "Você" never "o usuário." No corporate register.

**Native test**: read the copy aloud as someone from Buenos Aires or São Paulo. If it sounds translated, rewrite it.
