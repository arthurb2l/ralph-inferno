# Changelog

All notable changes to Ralph Inferno will be documented in this file.

## [1.0.7] - 2025-01-19

### Added
- **Language agnostic**: Auto-detect build/test commands (npm, cargo, go, make, python)
- **Custom commands**: Support `build_cmd` and `test_cmd` in config.json
- **Language setting**: Specs/PRD written in configured language (en, sv, etc.)
- Smart logging: Always log to `.ralph/logs/claude-raw.log`, errors to `errors.log`
- `/ralph:status` now shows last error details

### Changed
- All code/commands converted to English (output still respects language setting)
- `git push` now uses current branch instead of hardcoded `main`

### Removed
- **~90KB of deprecated code**:
  - `ralph-full.sh` (62KB legacy monolith)
  - `ralph-deploy.sh`, `ralph-review.sh`, `ralph-setup.sh`, `ralph-tmux.sh`, `vm-sync.sh`
  - `vm.sh`, `watch.sh`
  - `spec.md.template` (duplicate)

## [1.0.6] - 2025-01-16

### Added
- Better README with "How It Works" section
- Clear setup instructions for both local and VM
- vm-init.sh: nvm path fix, Playwright dependencies
- Smart logging (always to file, show on error)

## [1.0.5] - 2025-01-16

### Added
- `/ralph:update` command to check for new versions

### Fixed
- Version now read dynamically from package.json

## [1.0.4] - 2025-01-16

### Fixed
- ntfy topic now unique per install (was shared `ralph-notifications`)

## [1.0.3] - 2025-01-15

### Added
- Chrome Extension tip for discovery mode
- Cost tracking improvements

## [1.0.2] - 2025-01-15

### Fixed
- Various bug fixes from initial testing

## [1.0.1] - 2025-01-15

### Fixed
- npm package structure fixes

## [1.0.0] - 2025-01-15

### Added
- Initial release
- Three modes: Quick, Standard, Inferno
- Slash commands: `/ralph:discover`, `/ralph:plan`, `/ralph:deploy`, `/ralph:review`, `/ralph:change-request`, `/ralph:status`, `/ralph:abort`
- Test loop with Playwright E2E
- Auto-CR generation on test failure
- ntfy.sh notifications
- VM sandbox execution
- Cost/token tracking
