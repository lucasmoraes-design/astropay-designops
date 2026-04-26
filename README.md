# AstroPay Design Operations — Marketing AI

Sistema centralizado de conhecimento para o Marketing AI da AstroPay. Este repositório é a fonte da verdade para produção de criativos de paid media, email marketing e operação do design system via Claude.

---

## Estrutura

```
astropay-designops/
├── CLAUDE.md                    ← System prompt (lido automaticamente pelo Claude)
├── BRAND.md                     ← Voz, tom, produtos, campanhas, CTAs, disclaimers
├── PAID-MEDIA-AGENTS.md         ← Agentes de paid media + regras de produção Figma
├── EMAIL-AGENTS.md              ← Agentes de email + configuração Braze
├── tokens/
│   └── brand.json               ← Tokens de cor e tipografia
└── figma/
    └── components.json          ← Node IDs semânticos do Figma
```

---

## Como usar com Claude

1. Abra um novo projeto no Claude
2. Conecte este repositório via GitHub MCP
3. O Claude lerá o `CLAUDE.md` como system prompt automático
4. Comece a prompar — os agentes são ativados por tags ou automaticamente

**Exemplos de uso:**
```
"@all cria campanha de câmbio para AR e BR, todos os formatos"
"@email-all fluxo de reengajamento para usuários inativos do Infinite"
"@guardian revisa esse copy antes de eu aprovar"
```

---

## Atualizar o design system

### Tokens de cor/tipografia (`tokens/brand.json`)
Atualizar manualmente quando houver mudança no Figma Variables. Abrir PR com descrição da mudança.

### Node IDs de componentes (`figma/components.json`)
Atualizar manualmente após cada publish do design system. Futuramente: sync automático via GitHub Actions.

### Voz e agentes (`BRAND.md`, `*-AGENTS.md`)
Atualizar via PR — qualquer mudança de posicionamento, tom ou campanha nova.

---

## Roadmap

- [ ] GitHub Actions para sync automático de tokens via Figma REST API
- [ ] Transferir para organização AstroPay quando pronto para empresa
- [ ] Adicionar skill de validação automática de node IDs
