#!/usr/bin/env bash
#
# init_repo_structure.sh
# ----------------------
# Initializes a professional project directory structure.
# Logs a clear, descriptive message after creating each folder.

set -euo pipefail

#── Define each directory and a human-readable description
declare -A DIRS=(
  [src]="application source code"
  [lib]="shared libraries and modules"
  [tests]="unit & integration tests"
  [docs]="project documentation"
  [scripts]="utility scripts & automation tools"
  [bin]="executable scripts"
  [examples]="example usage & tutorials"
  [configs]="configuration files"
  [assets]="static assets (images, stylesheets, etc.)"
  [data]="datasets & database files"
  [logs]="log output"
  [reports]="generated reports"
  [.github]="GitHub metadata (issues, PR templates)"
  [.github/workflows]="CI/CD workflow definitions"
  [build]="build artifacts"
  [dist]="distribution packages"
)

#── Create each directory and echo a professional log message
for dir in "${!DIRS[@]}"; do
  mkdir -p "$dir"
  echo "✔ Created directory '$dir' for ${DIRS[$dir]}"
done

echo "✅ All directories have been set up successfully."
