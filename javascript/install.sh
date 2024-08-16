#!/usr/bin/env bash

echo "Intalling global npm packages..."
npm install -g npm-check-updates
npm install -g n
npm install -g typescript
npm install -g corepack

# Enable corepack for yarn and pnpm
corepack enable
