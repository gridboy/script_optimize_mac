# ⚡ Mac Optimizer Pro

[![License: GPL v3](https://img.shields.io/badge/license-GPLv3-blue.svg)](LICENSE)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey)
![Shell](https://img.shields.io/badge/shell-bash-89e051)
![Maintained](https://img.shields.io/badge/maintained-yes-success)
[![Docs](https://img.shields.io/badge/docs-online-blue)](https://gridboy.github.io/script_optimize_mac/)

A one-command deep clean and tune-up for your Mac. `optimize_pro.sh`
automates the maintenance routine power users normally run by hand: cache
cleanup, memory purge, DNS flush, local Time Machine snapshot cleanup,
Homebrew upkeep, Spotlight reindexing, and a disk check.

📖 **[Read the full documentation](https://gridboy.github.io/script_optimize_mac/)** — what each step does, in plain language.

## 🧰 Good to know before you run it

This script goes deep, so a few steps free up space by clearing things out
for good (caches, logs, local Time Machine snapshots) — the same cleanup a
power user would do by hand, just automated. As with any system maintenance,
it's good practice to have a recent backup on hand.

## Requirements

- macOS
- An account with administrator rights (the script prompts for your
  password via `sudo`)
- [Homebrew](https://brew.sh) (optional — the Homebrew maintenance step is
  skipped if `brew` is not installed)

## Usage

```bash
chmod +x optimize_pro.sh
./optimize_pro.sh
```

The script asks for confirmation before starting, then for your
administrator password (kept alive for the session for the duration of the
run).

## Steps performed

1. Clean system, user, and log caches
2. Clean system temporary files
3. Purge RAM
4. Flush the DNS cache
5. Remove local Time Machine snapshots
6. Homebrew maintenance (update / upgrade / autoremove / cleanup)
7. Reindex Spotlight
8. Verify the disk's file system

A detailed breakdown of each procedure (commands used, effects, impact) is
documented on the **[documentation site](https://gridboy.github.io/script_optimize_mac/)**
(source: [docs/index.html](docs/index.html)).

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for the
guidelines to follow before opening a pull request.

## License

Distributed under the GPL-3.0 license — see [LICENSE](LICENSE).
