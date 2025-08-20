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


## linear cli

- if asked to start the next issue, check out the main branch with `git main` (an alias), then list issues with `linear issue list`, note the id of the top one, and start it with `linear issue start <id>` - this should start the issue and checkout a branch
- see details about the current issue with linear-cli's `linear issue view` command
- if asked to implement the current issue or simply 'go', see the current issue details, implement it, and explain any caveats or possible improvements
- if asked to create a pr, first run diagnostics then create the pr with `linear issue pr`

### usage

linear cli provides commands to manage linear issues, teams, and projects from
the command line.

### repo configuration

first, configure the cli with your linear api token:

```bash
linear config
```

this will interactively generate a `.linear.toml` configuration file in the
repo.

### issues

#### list issues

list your issues (shows unstarted issues by default):

```bash
linear issue list
```

list issues with different states:

```bash
# List started issues
linear issue list --state started

# List all issues regardless of state
linear issue list --all-states

# List multiple states
linear issue list --state unstarted --state started
```

filter by assignee:

```bash
# List issues assigned to you
linear issue list --assignee self

# List issues assigned to specific user
linear issue list --assignee username

# List all unassigned issues
linear issue list --unassigned

# List issues for all assignees
linear issue list --all-assignees
```

other options:

```bash
# List issues for specific team
linear issue list --team TEAM

# Sort by priority instead of manual order
linear issue list --sort priority

# Open in web browser
linear issue list --web

# Open in Linear app
linear issue list --app
```

#### view issue details

view the current issue (based on git branch):

```bash
linear issue view
```

view a specific issue:

```bash
linear issue view TEAM-123
```

view options:

```bash
# Open in web browser
linear issue view TEAM-123 --web

# Open in Linear app
linear issue view TEAM-123 --app

# Exclude comments from output
linear issue view TEAM-123 --no-comments
```

#### start working on an issue

start the next available issue:

```bash
linear issue start
```

start a specific issue:

```bash
linear issue start TEAM-123
```

this will move the issue to "in progress" and create a git branch.

#### create an issue

create an issue interactively:

```bash
linear issue create
```

create with specific options:

```bash
# Create with title and description
linear issue create --title "Fix bug" --description "Description here"

# Create and assign to yourself
linear issue create --assignee self

# Create with priority (1-4, where 1 is highest)
linear issue create --priority 1

# Create with estimate points
linear issue create --estimate 3

# Create with labels
linear issue create --label bug --label frontend

# Create for specific team
linear issue create --team TEAM

# Create and start working on it
linear issue create --start
```

#### update an issue

update the current issue:

```bash
linear issue update
```

update a specific issue:

```bash
linear issue update TEAM-123
```

#### other issue commands

get issue id from current git branch:

```bash
linear issue id
```

get issue title:

```bash
linear issue title TEAM-123
```

get issue url:

```bash
linear issue url TEAM-123
```

create a github pull request:

```bash
linear issue pull-request
linear issue pr  # Short alias
```

delete an issue:

```bash
linear issue delete TEAM-123
```

### teams

#### list teams

```bash
linear team list
```

#### get team id

get team id derived from repository name:

```bash
linear team id
```

#### team members

list members of your default team:

```bash
linear team members
```

list members of a specific team:

```bash
linear team members TEAM
```

#### create a team

```bash
linear team create
```

#### configure github autolinks

set up github repository autolinks for linear issues:

```bash
linear team autolinks
```

### projects

#### list projects

```bash
linear project list
```

#### view project details

```bash
linear project view PROJECT-ID
```

### shell completions

generate shell completions for better command-line experience:

```bash
# For bash
source <(linear completions bash)

# For zsh
source <(linear completions zsh)

# For fish
linear completions fish | source
```

add the appropriate line to your shell's configuration file (e.g., `~/.bashrc`,
`~/.zshrc`, or `~/.config/fish/config.fish`).

### global options

most commands support these options:

- `--no-pager` - disable automatic paging for long output
- `--no-color` - disable colored output
- `--help` - show help for the command

### examples

common workflows:

```bash
# Start working on the next issue
linear issue start

# View current issue details
linear issue view

# Create and start a new bug fix
linear issue create --title "Fix login error" --label bug --start

# List high priority issues
linear issue list --sort priority

# Create a pull request for current issue
linear issue pr
```
