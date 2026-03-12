## jj-vcs

- use jj instead of git for source control
- if a repo isn't using jj yet, initialize it and track the default bookmark
- reference the jj skill if you are having trouble with commands

### squash workflow

- before starting work, check `@` is mutable: `jj log -r '@' --no-graph -T 'if(immutable, "IMMUTABLE", "ok")'`
- if `@` is immutable or non-empty, run `jj new` to create a fresh change
- never modify an immutable change — always create a new one on top
- do work in `@`, then `jj commit -m "msg"` to snapshot and get a fresh change

### avoid interactive jj commands (they hang agents)

- always pass `-m "msg"` to `describe`, `commit`, `squash` (without it they open `$EDITOR`)
- `squash` also accepts `-u` to keep the destination message
- `split` opens a diff editor by default, so always pass explicit file paths
- never use `-i`/`--interactive` on any command
- never run `diffedit`, `resolve`, `config edit`, `sparse edit`. use `config set`/`sparse set` instead

## tools

- duckdb and jq are available for reviewing data

## coding values

- strict inputs: reject unexpected shapes/types/values as far as the type system allows
- exhaustive matching; crash on unexpected states at runtime; never silently swallow
- assertions/invariants in production. silent corruption is worse than crashing
- no type casts (`as`, `# type: ignore`). fix the code so the types work
- parse, don't validate: schema+types at boundaries (Zod, Pydantic, serde)
- validate all config/env at startup. crash if missing
- explicit wiring over convention/metaprogramming/magic
- TDD when practical; test public interface, not internals
- ask before adding a new dependency
- structured logging with OTel when available
- backwards compat only matters with external clients; break freely otherwise
