#!/usr/bin/env bun

import { appendFile } from 'node:fs/promises';

async function runPipCommand(command, args = []) {
  const proc = Bun.spawn(["pip", command, ...args], {
    stdout: "pipe",
    stderr: "pipe",
  });

  const output = await new Response(proc.stdout).text();
  const error = await new Response(proc.stderr).text();
  const exitCode = await proc.exited;

  if (error.trim()) {
    console.error(error.trim());
  }

  if (exitCode !== 0) {
    throw new Error(`pip ${command} failed`);
  }

  return output.trim();
}

async function getExistingRequirements() {
  try {
    const file = Bun.file("requirements.txt");
    const exists = await file.exists();
    if (!exists) {
      return [];
    }
    const content = await file.text();
    return content.split("\n").filter(line => line.trim());
  } catch (error) {
    console.error("Warning: Could not read requirements.txt:", error.message);
    return [];
  }
}

function packageExists(packageName, requirements) {
  return requirements.some(line => {
    // Remove comments and whitespace
    line = line.split("#")[0].trim().toLowerCase();
    // Check if this line starts with our package name followed by any version specifier
    return line.startsWith(packageName.toLowerCase() + "==") ||
           line.startsWith(packageName.toLowerCase() + ">=") ||
           line.startsWith(packageName.toLowerCase() + "<=") ||
           line.startsWith(packageName.toLowerCase() + "~=");
  });
}

async function main() {
  // Get package name from command line
  const packageName = process.argv[2];
  if (!packageName) {
    console.error("Usage: pip-install-save.js <package-name>");
    process.exit(1);
  }

  try {
    // Read existing requirements first
    const existingRequirements = await getExistingRequirements();

    console.log(existingRequirements);

    // Check if package already exists
    if (packageExists(packageName, existingRequirements)) {
      console.log(`📝 ${packageName} is already in requirements.txt`);
      process.exit(0);
    }

    // Install the package
    console.log(`📦 Installing ${packageName}...`);
    await runPipCommand("install", [packageName]);

    // Get frozen requirements
    const frozen = await runPipCommand("freeze");
    
    // Find the line containing our package
    const packageLine = frozen.split("\n")
      .find(line => line.toLowerCase().startsWith(packageName.toLowerCase()));

    if (!packageLine) {
      throw new Error(`Could not find ${packageName} in pip freeze output`);
    }

    // Append to requirements.txt
    console.log(`📝 Adding ${packageLine} to requirements.txt`);
      await appendFile('requirements.txt', packageLine + "\n");

    console.log("✅ Done!");
  } catch (error) {
    console.error("❌ Error:", error.message);
    process.exit(1);
  }
}

main();
