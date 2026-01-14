# Ralph CLI Flags

## ralph.sh

The main entry point for running Ralph.

### Basic Usage

```bash
./ralph.sh              # Clean loop (default)
./ralph.sh --full       # Full mode with all features
./ralph.sh --status     # Show progress
./ralph.sh --watch      # Fireplace dashboard
./ralph.sh --help       # Show help
```

### Flags

| Flag | Short | Description |
|------|-------|-------------|
| `--full` | | Run full mode with parallel execution, worktrees |
| `--status` | `-s` | Show current progress (specs done/total) |
| `--watch` | `-w` | Live dashboard showing Ralph's progress |
| `--parallel` | | Use git worktrees for parallel spec execution |
| `--help` | `-h` | Show help message |

## Clean vs Full Mode

### Clean Mode (default)

- ~150 lines of code
- Sequential spec execution
- Simple and predictable
- Lower token usage
- Follows Ryan Carson / Geoffrey Huntley approach

```bash
./ralph.sh
```

### Full Mode

- ~1900 lines of code
- Parallel execution with git worktrees
- Automatic scaling based on rate limits
- Progress dashboard
- More complex, higher token usage

```bash
./ralph.sh --full
```

## When to Use Each Mode

| Use Case | Mode |
|----------|------|
| Most projects | Clean |
| Large projects (20+ specs) | Full |
| Debugging | Clean |
| Overnight runs | Either |
| Limited API credits | Clean |

## ralph-inferno CLI

```bash
npx ralph-inferno install   # Install Ralph in project
npx ralph-inferno update    # Update core files, keep config
```

### Install Options

During `install`, you'll be asked:
1. Language (en, sv, es, de, fr, zh)
2. Cloud provider (hcloud, gcloud, doctl, aws, ssh)
3. VM name and region
4. GitHub username (auto-detected from `gh` CLI)
5. ntfy.sh notifications (optional)
