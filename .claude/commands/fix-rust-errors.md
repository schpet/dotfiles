---
description: "Continuously fix Rust compilation and clippy errors until the project builds cleanly"
allowed-tools: ["Bash", "Read", "Edit", "MultiEdit", "Write", "TodoWrite"]
---

# Fix Rust Compilation and Clippy Errors

This command runs a loop that continuously checks for compilation and clippy errors, fixes them, and repeats until the project builds cleanly with no warnings.

## Instructions

1. **Initial Status Check**
   - Run `cargo build` to identify compilation errors
   - Run `cargo clippy -- -D warnings` to identify clippy warnings
   - If both pass, report success and exit

2. **Create Fix Plan**
   - Use TodoWrite to track all errors that need fixing
   - Prioritize compilation errors over clippy warnings
   - Group related errors together

3. **Fix Compilation Errors Loop**
   - While compilation errors exist:
     - Identify the first error from cargo build output
     - Read the affected file
     - Analyze the error and determine the fix
     - Apply the fix using Edit or MultiEdit
     - Mark the todo item as completed
     - Run `cargo build` again to check for remaining errors

4. **Fix Clippy Warnings Loop**
   - After all compilation errors are fixed:
   - While clippy warnings exist:
     - Run `cargo clippy -- -D warnings`
     - Identify the first warning
     - Read the affected file
     - Apply the suggested fix or refactor as needed
     - Mark the todo item as completed
     - Run clippy again to check for remaining warnings

5. **Final Verification**
   - Run `cargo build --release` to ensure release build works
   - Run `cargo test` to ensure tests still pass
   - Run `cargo fmt --check` to ensure code is properly formatted
   - Report success with a summary of all fixes made

6. **Error Handling**
   - If unable to fix an error after 3 attempts, document the issue
   - If tests fail after fixes, revert the last change and try alternative approach
   - Keep track of all changes made for potential rollback

Continue this process until both `cargo build` and `cargo clippy -- -D warnings` run successfully with no errors or warnings.
