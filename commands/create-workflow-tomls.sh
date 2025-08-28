#!/bin/bash

# ==============================================================================
#
# setup_advanced_cmmi_workflow.sh
#
# Description:
#   This script sets up a dynamic, CMMI-aligned, and loosely coupled workflow
#   for the Gemini CLI. It creates a directory structure and a series of
#   specialized TOML files that enable a sophisticated, agent-driven project
#   lifecycle, from initiation to closing.
#
# Features:
#   - Loosely Coupled Architecture: Each phase is managed by its own set of
#     commands, allowing for greater flexibility and extensibility.
#   - Dynamic Backlog Generation: The workflow starts with a `scope.toml`
#     that parses a user's requirements to create a backlog and identify
#     the necessary AI agents.
#   - Integrated Change Control: Each phase includes a `change.toml` for
#     managing new requirements, modifications, and re-runs, with a full
#     audit trail.
#   - Comprehensive Dashboard: A dynamic `dashboard.toml` is created to
#     monitor project status, including a new section for tracking agent
#     performance.
#   - Idempotent and Safe: The script checks for existing files and
#     directories, creating backups before writing new files.
#
# Usage:
#   1. Place this script in your ~/.gemini/commands/ directory.
#   2. Make it executable: chmod +x setup_advanced_cmmi_workflow.sh
#   3. Run it from the ~/.gemini/commands/ directory: ./setup_advanced_cmmi_workflow.sh
#
# ==============================================================================

# --- Configuration ---

# The base directory for the commands. This should be the directory where the
# script is located.
BASE_DIR="$(pwd)"

# The list of phases in the CMMI workflow.
PHASES=("initiator" "plan" "design" "implement" "deploy" "closing")

# --- Helper Functions ---

# Function to create a directory if it doesn't already exist.
#
# @param $1: The path of the directory to create.
create_directory() {
  if [ ! -d "$1" ]; then
    echo "Creating directory: $1"
    mkdir -p "$1"
  else
    echo "Directory already exists: $1"
  fi
}

# Function to create a TOML file with a backup if it already exists.
#
# @param $1: The path of the file to create.
# @param $2: The content to write to the file.
create_toml_file() {
  local file_path="$1"
  local content="$2"

  if [ -f "$file_path" ]; then
    local backup_path="${file_path}.bak"
    echo "Backing up existing file to: $backup_path"
    mv "$file_path" "$backup_path"
  fi

  echo "Creating TOML file: $file_path"
  echo -e "$content" > "$file_path"
}

# --- Main Script ---

echo "Starting the setup of the Advanced CMMI Workflow for Gemini CLI..."
echo "Base directory: $BASE_DIR"
echo ""

# --- Create Phase Directories ---

echo "--- Creating Phase Directories ---"
for phase in "${PHASES[@]}"; do
  create_directory "$BASE_DIR/$phase"
done
echo ""

# --- Create TOML Files ---

echo "--- Creating TOML Files ---"

# 1. Initiator Phase
#    - scope.toml: The entry point of the workflow. It takes a POML file with
#      user requirements and generates the initial backlog and identified agents.
#    - change.toml: Manages changes and re-runs for the initiator phase.
initiator_scope_content="description = \"Parses a POML file to generate the initial project backlog and identify the required AI agents.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Project Initiation Agent.</role>\n  <context>\n    <p>The user has provided the following requirements in a POML file. Your task is to:</p>\n    <list>\n      <item>Analyze the requirements to create a detailed, CMMI-compliant project backlog.</item>\n      <item>Identify all the specialized AI agents (Identified Agents) needed to execute the project.</item>\n      <item>Generate two files: 'backlog.md' and 'identified_agents.md'.</item>\n    </list>\n    <p>User Requirements (POML):</p>\n    <pre>{{args}}</pre>\n  </context>\n  <task>\n    <p>Generate the 'backlog.md' and 'identified_agents.md' files based on the provided requirements.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/initiator/scope.toml" "$initiator_scope_content"

initiator_change_content="description = \"Manages changes to the project scope and initial artifacts.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Change Control Agent for the Initiation phase.</role>\n  <context>\n    <p>A change has been requested for the initial project scope. Your tasks are to:</p>\n    <list>\n      <item>Analyze the change request and its impact on the existing 'backlog.md' and 'identified_agents.md'.</item>\n      <item>Update these artifacts, maintaining a versioned history of the changes.</item>\n      <item>Log the change in the 'change_log.md' file.</item>\n    </list>\n    <p>Change Request:</p>\n    <pre>{{args}}</pre>\n  </context>\n  <task>\n    <p>Process the change request and update the project artifacts accordingly.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/initiator/change.toml" "$initiator_change_content"

# 2. Plan Phase
#    - quantify.toml: Takes the backlog and creates a detailed project plan.
#    - change.toml: Manages changes to the project plan.
plan_quantify_content="description = \"Creates a detailed project plan from the backlog.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Project Planning Agent.</role>\n  <context>\n    <p>Using the 'backlog.md' and 'identified_agents.md', create a comprehensive project plan. This plan should include:</p>\n    <list>\n      <item>A Work Breakdown Structure (WBS).</item>\n      <item>Timelines and milestones (Gantt chart).</item>\n      <item>Resource allocation (assigning agents to tasks).</item>\n      <item>A risk assessment and mitigation plan.</item>\n    </list>\n  </context>\n  <task>\n    <p>Generate the 'project_plan.md' file.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/plan/quantify.toml" "$plan_quantify_content"

plan_change_content="description = \"Manages changes to the project plan.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Change Control Agent for the Planning phase.</role>\n  <context>\n    <p>A change has been requested that affects the project plan. Your tasks are to:</p>\n    <list>\n      <item>Analyze the change and its impact on the 'project_plan.md'.</item>\n      <item>Update the plan, including the WBS, timelines, and resource allocation.</item>\n      <item>Log the change in the 'change_log.md'.</item>\n    </list>\n    <p>Change Request:</p>\n    <pre>{{args}}</pre>\n  </context>\n  <task>\n    <p>Process the change request and update the project plan.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/plan/change.toml" "$plan_change_content"

# 3. Design Phase
#    - refine.toml: Refines the project plan into detailed technical specifications.
#    - change.toml: Manages changes to the design specifications.
design_refine_content="description = \"Refines the project plan into detailed technical specifications.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a System Design Agent.</role>\n  <context>\n    <p>Based on the 'project_plan.md', create detailed design and technical specifications. This should include:</p>\n    <list>\n      <item>Architecture diagrams (using Mermaid.js).</item>\n      <item>Data models and schemas.</item>\n      <item>API endpoint definitions.</item>\n      <item>User interface mockups or wireframes.</item>\n    </list>\n  </context>\n  <task>\n    <p>Generate the 'design_specifications.md' file.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/design/refine.toml" "$design_refine_content"

design_change_content="description = \"Manages changes to the design specifications.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Change Control Agent for the Design phase.</role>\n  <context>\n    <p>A change has been requested that affects the design specifications. Your tasks are to:</p>\n    <list>\n      <item>Analyze the change and its impact on the 'design_specifications.md'.</item>\n      <item>Update the design documents, including diagrams and data models.</item>\n      <item>Log the change in the 'change_log.md'.</item>\n    </list>\n    <p>Change Request:</p>\n    <pre>{{args}}</pre>\n  </context>\n  <task>\n    <p>Process the change request and update the design specifications.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/design/change.toml" "$design_change_content"

# 4. Implement Phase
#    - generate.toml: Generates the code and other deliverables.
#    - change.toml: Manages changes to the implementation.
implement_generate_content="description = \"Generates the code and other deliverables based on the design specifications.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Code Generation Agent.</role>\n  <context>\n    <p>Using the 'design_specifications.md', generate the source code and any other required deliverables. Your output should be:</p>\n    <list>\n      <item>Well-structured, commented, and production-ready code.</item>\n      <item>Unit tests for all generated code.</item>\n      <item>Any necessary configuration files.</item>\n    </list>\n  </context>\n  <task>\n    <p>Generate the implementation and place it in the '/src' directory.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/implement/generate.toml" "$implement_generate_content"

implement_change_content="description = \"Manages changes to the implementation.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Change Control Agent for the Implementation phase.</role>\n  <context>\n    <p>A change has been requested that affects the source code. Your tasks are to:</p>\n    <list>\n      <item>Analyze the change and its impact on the codebase.</item>\n      <item>Update the code and associated unit tests.</item>\n      <item>Log the change in the 'change_log.md'.</item>\n    </list>\n    <p>Change Request:</p>\n    <pre>{{args}}</pre>\n  </context>\n  <task>\n    <p>Process the change request and update the implementation.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/implement/change.toml" "$implement_change_content"

# 5. Deploy Phase
#    - release.toml: Creates a release plan for deploying the application.
#    - change.toml: Manages changes to the release plan.
deploy_release_content="description = \"Creates a release plan for deploying the application.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Release Management Agent.</role>\n  <context>\n    <p>Create a detailed release plan for deploying the application. This plan should include:</p>\n    <list>\n      <item>A step-by-step deployment checklist.</item>\n      <item>A rollback plan in case of failure.</item>\n      <item>A communication plan for notifying stakeholders.</item>\n      <item>A post-deployment verification plan.</item>\n    </list>\n  </context>\n  <task>\n    <p>Generate the 'release_plan.md' file.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/deploy/release.toml" "$deploy_release_content"

deploy_change_content="description = \"Manages changes to the release plan.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Change Control Agent for the Deployment phase.</role>\n  <context>\n    <p>A change has been requested that affects the release plan. Your tasks are to:</p>\n    <list>\n      <item>Analyze the change and its impact on the 'release_plan.md'.</item>\n      <item>Update the deployment and rollback procedures.</item>\n      <item>Log the change in the 'change_log.md'.</item>\n    </list>\n    <p>Change Request:</p>\n    <pre>{{args}}</pre>\n  </context>\n  <task>\n    <p>Process the change request and update the release plan.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/deploy/change.toml" "$deploy_change_content"

# 6. Closing Phase
#    - finalize.toml: Finalizes the project and generates a closure report.
#    - change.toml: Manages any final changes or adjustments.
closing_finalize_content="description = \"Finalizes the project and generates a closure report.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Project Closure Agent.</role>\n  <context>\n    <p>The project is now complete. Your final task is to generate a project closure report. This report should include:</p>\n    <list>\n      <item>A summary of the project's objectives and outcomes.</item>\n      <item>A review of the project's performance against the plan.</item>\n      <item>Lessons learned and recommendations for future projects.</item>\n      <item>Final metrics from the 'dashboard.md'.</item>\n    </list>\n  </context>\n  <task>\n    <p>Generate the 'project_closure_report.md' file.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/closing/finalize.toml" "$closing_finalize_content"

closing_change_content="description = \"Manages any final changes or adjustments before project closure.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Change Control Agent for the Closing phase.</role>\n  <context>\n    <p>A final change or adjustment has been requested before the project is officially closed. Your tasks are to:</p>\n    <list>\n      <item>Analyze the request and its impact on the final deliverables.</item>\n      <item>Make any necessary final adjustments.</item>\n      <item>Log the change in the 'change_log.md'.</item>\n    </list>\n    <p>Change Request:</p>\n    <pre>{{args}}</pre>\n  </context>\n  <task>\n    <p>Process the final change request.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/closing/change.toml" "$closing_change_content"

# 7. Dashboard
#    - dashboard.toml: Creates and maintains the main project dashboard.
dashboard_content="description = \"Creates and maintains the main project dashboard with agent performance monitoring.\"\nprompt = \"\"\"\n<poml>\n  <role>You are a Dashboard Management Agent.</role>\n  <context>\n    <p>Your task is to create and continuously update the 'dashboard.md' file. This dashboard is the single source of truth for the project and should include the following sections:</p>\n    <list>\n      <item>Overall Project Status (with a high-level Gantt chart).</item>\n      <item>Key Metrics (budget, schedule, quality).</item>\n      <item>Current Phase and Tasks.</item>\n      <item>Risks and Issues.</item>\n      <item>Change Log Summary.</item>\n      <item>Agent Performance Monitor.</item>\n    </list>\n    <p>The 'Agent Performance Monitor' section should track the outcomes of each agent, grouped by phase and task, to identify high-performing agents.</p>\n  </context>\n  <task>\n    <p>Generate or update the 'dashboard.md' file.</p>\n  </task>\n</poml>\n\"\"\""
create_toml_file "$BASE_DIR/dashboard.toml" "$dashboard_content"

echo ""
echo "--- Setup Complete ---"
echo "The Advanced CMMI Workflow has been successfully set up in your Gemini CLI."
echo "You can now start your project by running: /initiator/scope \"<your_poml_file_content>\""
echo "Enjoy your new, dynamic workflow!"
