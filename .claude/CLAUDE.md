## Figma CLI Usage

A command-line tool for working with Figma designs
(https://github.com/schpet/figma-cli)

### Commands

#### `figma node export <url>`

Download a Figma node as an image file. Prints the path the image is saved to.

```bash
figma node export "https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH"
```

**Options:**

- `-o, --output <path>` - Output file path (optional)

**Examples:**

```bash
# Export to specific file
figma node export "https://www.figma.com/design/abc123/My-Design?node-id=1%3A2&t=xyz" -o ./exports/design.png
```

#### `figma node url <url>`

Show the direct image URL from Figma API without downloading.

```bash
figma node url "https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH"
```

## linear cli

- if asked to start the next issue, check out the main branch with `git main` (an alias), then list issues with `linear issue list`, note the id of the top one, and start it with `linear issue start <id>` - this should start the issue and checkout a branch
- see details about the current issue with linear-cli's `linear issue view` command
- if asked to implement the current issue or simply 'go', see the current issue details (via linear view, assume your branch indicates the id already), implement it, and explain any caveats or possible improvements
- if asked to create a pr, first run diagnostics then create the pr with `linear issue pr`
