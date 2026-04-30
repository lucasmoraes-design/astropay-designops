#!/bin/bash
# =============================================================================
# AstroPay DesignOps — GitHub Repository Setup
# Roda uma vez para criar o repo e fazer o push inicial
# Uso: bash setup.sh
# =============================================================================

set -e

GITHUB_USER="lucasmoraes-design"
REPO_NAME="astropay-designops"
REPO_DESC="AstroPay Marketing AI — Design Operations knowledge base"

echo ""
echo "🚀 AstroPay DesignOps — Setup"
echo "================================"

# 1. Verifica se o GitHub CLI está instalado
if ! command -v gh &> /dev/null; then
  echo ""
  echo "❌ GitHub CLI não encontrado."
  echo "   Instale em: https://cli.github.com"
  echo "   Depois rode: gh auth login"
  exit 1
fi

# 2. Verifica autenticação
echo ""
echo "✅ Verificando autenticação GitHub..."
gh auth status

# 3. Cria o repositório privado
echo ""
echo "📁 Criando repositório $GITHUB_USER/$REPO_NAME..."
gh repo create "$REPO_NAME" \
  --private \
  --description "$REPO_DESC" \
  --confirm 2>/dev/null || echo "   (repositório já existe, continuando...)"

# 4. Inicializa git local
echo ""
echo "📝 Inicializando repositório local..."
git init
git add .
git commit -m "chore: initial commit — AstroPay DesignOps knowledge base

- CLAUDE.md: system prompt
- BRAND.md: voice, tone, products, campaigns
- AGENTS-SHARED.md: cross-channel agents (CD, copy, guardian, legal)
- PAID-MEDIA-AGENTS.md: paid media agents + Figma production
- tokens/brand.json: color and typography tokens
- figma/components.json: semantic Figma node IDs"

# 5. Push para o GitHub
echo ""
echo "🚀 Fazendo push para GitHub..."
git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git" 2>/dev/null || \
  git remote set-url origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
git branch -M main
git push -u origin main

echo ""
echo "✅ Repositório criado com sucesso!"
echo ""
echo "🔗 URL: https://github.com/$GITHUB_USER/$REPO_NAME"
echo ""
echo "Próximos passos:"
echo "  1. Abra um novo Project no Claude"
echo "  2. Conecte o GitHub MCP"
echo "  3. Adicione este repositório ao Project"
echo "  4. Comece a usar os agentes 🎯"
