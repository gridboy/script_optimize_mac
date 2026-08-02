# script_optimize_mac

A bash script (`optimize_pro.sh`) for advanced optimization and maintenance
of macOS.

It automates a series of system upkeep tasks: cache cleanup, memory purge,
DNS flush, removal of local Time Machine snapshots, Homebrew maintenance,
Spotlight reindexing, and a disk check.

## ⚠️ Warning

This script performs deep system operations, including irreversible
deletions (caches, logs, local Time Machine snapshots). **Make sure you
have a recent backup of your data before running it.**

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

A detailed breakdown of each procedure (commands used, effects, risks) is
documented in: **[docs/index.html](docs/index.html)**.

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for the
guidelines to follow before opening a pull request.

## License

Distributed under the GPL-3.0 license — see [LICENSE](LICENSE).
