#!/usr/bin/env bun

import { $ } from "bun";

async function installPackages(packageNames) {
  await $`bun install --global ${packageNames}`;
}

async function main() {
  await installPackages([
    "eslint",
    "eslint_d",
    "typescript-language-server",
    "prettier",
  ]);
}

await main();
