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
# Export to temporary directory
figma node export "https://www.figma.com/design/abc123/My-Design?node-id=1%3A2&t=xyz"

# Export to specific file
figma node export "https://www.figma.com/design/abc123/My-Design?node-id=1%3A2&t=xyz" -o ./exports/design.png

# Export to current directory
figma node export "https://www.figma.com/design/abc123/My-Design?node-id=1%3A2&t=xyz" -o design.png
```

#### `figma node copy <url>`

Copy a Figma node as an image to clipboard.

```bash
figma node copy "https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH"
```

**Options:**

- `-o, --output <path>` - Output file path (optional)

**Examples:**

```bash
# Copy to clipboard only
figma node copy "https://www.figma.com/design/abc123/My-Design?node-id=1%3A2&t=xyz"

# Copy to clipboard and save to specific file
figma node copy "https://www.figma.com/design/abc123/My-Design?node-id=1%3A2&t=xyz" -o ./my-image.png
```

#### `figma node url <url>`

Show the direct image URL from Figma API without downloading.

```bash
figma node url "https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH"
```

**Examples:**

```bash
# Get direct image URL
figma node url "https://www.figma.com/design/abc123/My-Design?node-id=1%3A2&t=xyz"
```

### URL Format

Figma URLs should follow this format:

```
https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH
```

- `FILE_ID`: The unique identifier for the Figma file
- `NODE_ID`: The specific node identifier (usually in format like `1%3A2`)
- `HASH`: The sharing hash parameter

### Output Behavior

- **File paths**: The `-o, --output` option always specifies a file path (like
  `curl -o`)
- **No output specified**: Creates a temporary directory with auto-generated
  filename
- **Clipboard copying**: On macOS, the `copy` command automatically copies the
  image to the clipboard
