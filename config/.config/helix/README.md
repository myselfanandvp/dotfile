# Global Node.js Tools Setup

This repository/directory contains the configuration to easily reinstall all global Node.js language servers, formatters, and utilities used for your development environment (such as Helix) on a fresh system.

## Included Tools[cite: 1]
- **@dprint/dockerfile** (0.5.0) - Dockerfile formatter plugin[cite: 1]
- **@dprint/formatter** (0.5.1) - Core dprint formatter engine[cite: 1]
- **@microsoft/compose-language-service** (0.5.0) - Docker Compose language support[cite: 1]
- **dockerfile-language-server-nodejs** (0.15.0) - Dockerfile language server[cite: 1]
- **prettier** (3.9.6) - Code formatter for JavaScript, TypeScript, YAML, etc[cite: 1].
- **typescript** (7.0.2) - TypeScript compiler and language core[cite: 1]
- **typescript-language-server** (5.3.0) - LSP for JavaScript and TypeScript[cite: 1]
- **yaml-language-server** (1.24.0) - LSP for YAML files[cite: 1]

---

## Installation Guide (Fresh System)[cite: 1]

1. Ensure you have **Node.js** and **npm** installed[cite: 1].
2. Place the `package.json` file in a dedicated directory on your new machine[cite: 1].
3. Open your terminal in that directory and run the following command to install all packages **globally** with their exact locked versions[cite: 1]:

```bash
npm install -g $(node -p "Object.entries(require('./package.json').dependencies).map(([pkg, ver]) => pkg + '@' + ver).join(' ')")



'''


{
  "name": "my-helix-global-tools",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "@dprint/dockerfile": "0.5.0",
    "@dprint/formatter": "0.5.1",
    "@microsoft/compose-language-service": "0.5.0",
    "dockerfile-language-server-nodejs": "0.15.0",
    "prettier": "3.9.6",
    "typescript": "7.0.2",
    "typescript-language-server": "5.3.0",
    "yaml-language-server": "1.24.0"
  }
}

'''
