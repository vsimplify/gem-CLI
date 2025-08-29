# Change Log

## [Unreleased]

### Added
- Enforced a new rule that every future invocation of any TOML file should also update the `User-Guide_TheDynamicCMMI-AgileWorkflow.md` file with the current state from `change_log.md`.
- Enhanced the CMMI framework with a context-aware chat capability.
    - Created a new top-level command directory named `chat`.
    - Inside this `chat` directory, created a new `with.toml` file.
    - Enforced a new standard where all artifacts created in the `docs/cmmi-artifacts` folder must include a unique ID, tags, and a component name.
- Created `commands/sh/2.3-fix-implement.toml` to configure Ollama and SearXNG models in `src/config/config.yaml`.
- Added a new `bugs` workflow to the CMMI framework. This includes the `bugs` directory and the following TOML files: `define.toml`, `analyze.toml`, `fix.toml`, `retest.toml`, and `deploy.toml`.
- Centralized all CMMI artifacts into the `docs/cmmi-artifacts` directory. This involved moving all markdown files and updating all TOML files to reference the new location.

## Change Log Entry: August 29, 2025

### Change Request: Enhance CMMI framework with context-aware discussion capability.

**Rationale:** To provide users with a context-aware discussion feature, allowing them to troubleshoot and ask questions with relevant project artifacts loaded into context. The command directory was renamed from 'chat' to 'discuss' to avoid conflict with built-in CLI functionality.

**Impacted Artifacts:**
*   `docs/cmmi-artifacts/backlog.md`: Refactored to a SAFe-inspired, CMMI-compliant structure (Focus Areas, Capabilities). Added "Context-Aware Chat" and "Artifact Standard Enforcement" capabilities.
*   `docs/cmmi-artifacts/identified_agents.md`: The "Discussion Agent" description was updated to reflect its specific role in context-aware chat.
*   `commands/chat/`: Renamed to `commands/discuss/`.
*   `commands/discuss/with.toml`: New command definition file created for the 'discuss with' command, defining the artifact search and loading steps for context.

**New Standard Enforced:** All artifacts created in the `docs/cmmi-artifacts` folder must now include a unique ID, relevant tags, and the associated Capability name (serving as the component identifier).

## Change Log Entry: August 29, 2025 (Correction)

### Correction: User Guide Update Oversight

**Rationale:** Corrected an oversight where `docs/cmmi-artifacts/User-Guide_TheDynamicCMMI-AgileWorkflow.md` was not updated with information regarding the new `/discuss` command and the enforced artifact standards during the previous change request. This update ensures compliance with the established rule that the user guide should reflect the current state from the change log.

**Impacted Artifacts:**
*   `docs/cmmi-artifacts/User-Guide_TheDynamicCMMI-AgileWorkflow.md`: Updated to include a new section for the `/discuss` command and a note about the new artifact standard in the `change_log.md` description.
