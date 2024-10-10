#!/usr/bin/env bun

import { $ } from "bun";
import { readFileSync } from 'fs';


const filePath = Bun.argv[2]; // Get the first command-line argument after the script name

if (!filePath) {
  console.error('Please provide a file path as an argument.');
  process.exit(1);
}

try {
  const fileContent = readFileSync(filePath, 'utf-8');
  const output = `${filePath}\n\`\`\`\n${fileContent}\n\`\`\``;
  console.log(output);
} catch (error) {
  console.error(`Error reading file: ${error.message}`);
  process.exit(1);
}
