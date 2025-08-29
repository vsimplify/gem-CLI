# Change Log

## [Unreleased]

### Added
- Enhanced the CMMI framework with a context-aware chat capability.
    - Created a new top-level command directory named `chat`.
    - Inside this `chat` directory, created a new `with.toml` file.
    - Enforced a new standard where all artifacts created in the `docs/cmmi-artifacts` folder must include a unique ID, tags, and a component name.
- Created `commands/sh/2.3-fix-implement.toml` to configure Ollama and SearXNG models in `src/config/config.yaml`.
- Added a new `bugs` workflow to the CMMI framework. This includes the `bugs` directory and the following TOML files: `define.toml`, `analyze.toml`, `fix.toml`, `retest.toml`, and `deploy.toml`.
- Centralized all CMMI artifacts into the `docs/cmmi-artifacts` directory. This involved moving all markdown files and updating all TOML files to reference the new location.
