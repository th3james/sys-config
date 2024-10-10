#!/usr/bin/env bun

import { $ } from "bun";
import { createInterface } from "readline";

async function getProcessIds(processName) {
  const result = await $`pgrep ${processName}`.text();
  return result.trim().split('\n').filter(Boolean);
}

function prompt(question) {
  const rl = createInterface({
    input: process.stdin,
    output: process.stdout
  });

  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      rl.close();
      resolve(answer);
    });
  });
}

async function main() {
  const processName = "eslint_d";
  const processIds = await getProcessIds(processName);

  if (processIds.length === 0) {
    console.log(`No ${processName} processes found.`);
    return;
  }

  console.log(`Found ${processName} processes with IDs: ${processIds.join(', ')}`);
  const answer = await prompt(`Do you want to stop these ${processName} processes? (y/n) `);

  if (answer.toLowerCase() === 'y') {
    try {
      await $`kill ${processIds}`;
      console.log(`Successfully stopped ${processName} processes.`);
    } catch (error) {
      console.error(`Error stopping ${processName} processes:`, error.message);
    }
  } else {
    console.log("Operation cancelled.");
  }
}

await main();
