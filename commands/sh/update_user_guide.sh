#!/bin/bash

# This script updates the user guide with the latest changes from the change log.

CHANGELOG_FILE="docs/cmmi-artifacts/change_log.md"
USERGUIDE_FILE="docs/cmmi-artifacts/User-Guide_TheDynamicCMMI-AgileWorkflow.md"

# Append the changelog to the user guide.
cat "$CHANGELOG_FILE" >> "$USERGUIDE_FILE"
