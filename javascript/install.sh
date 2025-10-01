#!/usr/bin/env bash
set -eu

echo "Intalling global npm packages..."
npm install -g npm-check-updates
npm install -g n
npm install -g typescript
npm install -g corepack
npm install -g @anthropic-ai/claude-code

# Enable corepack for yarn and pnpm
corepack enable
