# Contributing

Thanks for considering a contribution to `script_optimize_mac`.

## Before you start

- Open an issue first for anything beyond a trivial fix (typo, comment,
  doc tweak), so the change can be discussed before you spend time on it.
- This script runs destructive, `sudo`-level operations on a user's Mac.
  Any change to what it deletes, modifies, or executes must be clearly
  justified and called out in the PR description.

## Making changes

1. Fork the repository and create a branch from `main`:
   `git checkout -b fix/short-description` or `feat/short-description`.
2. Keep changes focused — one logical change per pull request.
3. Follow the existing style of `optimize_pro.sh`:
   - one function per maintenance step, named `verb_noun` (e.g. `clean_caches`)
   - use the existing color variables (`GREEN`, `YELLOW`, `BLUE`, `NC`) for
     output instead of introducing new ones
   - fail gracefully: destructive commands should not abort the whole
     script (see the existing `|| true` usage) unless failing loudly is the
     intended behavior
   - keep `set -e` behavior in mind — don't reintroduce commands that would
     abort the script on a routine, expected non-zero exit
4. Lint your changes with [ShellCheck](https://www.shellcheck.net/) before
   submitting:
   ```bash
   shellcheck optimize_pro.sh
   ```
5. Test manually on a real or virtual macOS machine. Since the script is
   destructive by nature, describe in the PR what you tested and how.
6. If you add, remove, or change a maintenance step, update:
   - `README.md` (the "Steps performed" list)
   - `docs/index.html` (the corresponding step entry, including risk level)

## Commit messages

Use short, imperative commit messages (e.g. `Add disk space check before cleanup`,
not `Added` or `Adding`). Reference the related issue number when relevant.

## Pull requests

- Describe what the change does and why.
- Call out any new destructive operation or new `sudo` usage explicitly.
- Make sure the PR only touches files relevant to the change.

## Code of conduct

Be respectful and constructive in issues and reviews. Disagreements about
approach are fine; personal attacks are not.
