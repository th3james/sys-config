#!/usr/bin/env bun

async function runCommand(command, args = []) {
  console.log(`🚀 Running: ${command} ${args.join(" ")}`);
  
  const proc = Bun.spawn([command, ...args], {
    stdout: "pipe",
    stderr: "pipe",
  });

  const output = await new Response(proc.stdout).text();
  const error = await new Response(proc.stderr).text();
  const exitCode = await proc.exited;

  if (output.trim()) {
    console.log(output.trim());
  }
  
  if (error.trim()) {
    console.error(error.trim());
  }

  return exitCode;
}

async function main() {
  let hasErrors = false;
  
  // Get files from command line arguments, defaulting to "." if none provided
  const files = process.argv.slice(2).length > 0 ? process.argv.slice(2) : ["."];

  // Run formatter first since it modifies files
  const formatExitCode = await runCommand("ruff", ["format", ...files]);
  if (formatExitCode !== 0) {
    hasErrors = true;
    console.error("❌ Formatting failed");
  }

  // Run checks in parallel since they don't modify files
  const [checkExitCode, pyrightExitCode] = await Promise.all([
    runCommand("ruff", ["check", ...files]),
    runCommand("pyright", files),
  ]);

  if (checkExitCode !== 0) {
    hasErrors = true;
    console.error("❌ Linting failed");
  }

  if (pyrightExitCode !== 0) {
    hasErrors = true;
    console.error("❌ Type checking failed");
  }

  process.exit(hasErrors ? 1 : 0);
}

main().catch((error) => {
  console.error("❌ Script failed:", error);
  process.exit(1);
});
