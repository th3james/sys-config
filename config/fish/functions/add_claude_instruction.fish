#!/usr/bin/env fish

# Script to append specific prompt files to CLAUDE.md in the current directory.
#
# Usage:
# 1. Save this file, for example, as `add_claude_instruction.fish` in a directory in your PATH,
#    or in `~/.config/fish/functions/` to make it an autoloaded function.
# 2. If saved as a general script file (e.g., in `~/bin`), make it executable:
#    `chmod +x add_claude_instruction.fish`
# 3. Then you can run it like:
#    `add_claude_instruction python general` (if in PATH or as a function)
#    OR
#    `./path/to/add_claude_instruction.fish python general` (if running as a direct script)

function add_claude_instruction
    # Base directory where your prompt markdown files are stored
    set base_prompts_dir "$HOME/src/sys-config/prompts"
    
    # The name of the output file in the current working directory
    set output_file_basename "CLAUDE.md"
    
    # For clearer messages, use the absolute path to the output file
    set output_file_for_messages "$PWD/$output_file_basename"

    # Check if any arguments (instruction names) were provided
    if test (count $argv) -eq 0
        echo "Usage: add_claude_instruction <name1> [<name2> ...]"
        echo "Example: add_claude_instruction python general"
        echo "This will append contents from '$base_prompts_dir/name1.md', etc., to './$output_file_basename'"
        return 1 # Exit with an error code
    end

    set any_file_appended false

    # Loop through each instruction name provided as an argument
    for instruction_name in $argv
        set source_file "$base_prompts_dir/$instruction_name.md"

        # Check if the source markdown file exists
        if test -f "$source_file"
            # If CLAUDE.md already exists and has content, add a blank line for separation
            # before adding the new section.
            if test -s "$output_file_basename" # -s checks if file exists and is > 0 size
                echo "" >> "$output_file_basename"
            else if not test -e "$output_file_basename" # File does not exist at all yet
                # Print a message only when creating the file for the first time
                echo "Creating $output_file_for_messages..."
            end
            
            # Append a Markdown horizontal rule as a separator
            echo "---" >> "$output_file_basename"
            # Append the content of the source file
            cat "$source_file" >> "$output_file_basename"

            echo "Appended: $source_file to $output_file_for_messages"
            set any_file_appended true
        else
            # Print a warning if the source file for an argument is not found
            echo "Warning: Source file not found: $source_file (for argument '$instruction_name')"
        end
    end

    # Final status message
    if $any_file_appended
        echo "Done. Specified instructions appended to $output_file_for_messages."
        return 0 # Success
    else
        echo "No instructions were appended. Check file names or if source files exist."
        return 1 # Failure or nothing done
    end
end