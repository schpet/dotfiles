# CLAUDE.md

This is the dotfiles repository. It is stowed into `$HOME`, so changes here affect the live environment.

## Before making changes

This repo changes frequently. Before the first edit in any new agent session, always catch up:

```sh
jj git fetch && jj rebase -d main
```

Do this before inspecting or editing files so you are working against the latest state.

## jj workflow

- use jj instead of git for source control
- before starting work, check `@` is mutable: `jj log -r '@' --no-graph -T 'if(immutable, "IMMUTABLE", "ok")'`
- if `@` is immutable or non-empty, run `jj new` to create a fresh change
- never modify an immutable change — always create a new one on top
- always pass `-m "msg"` to `describe`, `commit`, and `squash`
- never use interactive jj commands that open editors or UIs

## Dotfiles-specific rules

- be careful: changes here can immediately affect shell, agent, editor, and system behavior
- prefer minimal, surgical edits
- if changing agent config, keep shared instructions in the canonical location when possible instead of duplicating them
- keep repo-only files like this one out of `$HOME` via `.stow-local-ignore`
- before pushing, review the diff for secrets or machine-local junk
