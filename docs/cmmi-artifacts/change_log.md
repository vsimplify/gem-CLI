# Change Log

## [Unreleased]

### Added
- Created `commands/sh/2.3-fix-implement.toml` to configure Ollama and SearXNG models in `src/config/config.yaml`.
- Added a new `bugs` workflow to the CMMI framework. This includes the `bugs` directory and the following TOML files: `define.toml`, `analyze.toml`, `fix.toml`, `retest.toml`, and `deploy.toml`.
- Centralized all CMMI artifacts into the `docs/cmmi-artifacts` directory. This involved moving all markdown files and updating all TOML files to reference the new location.
