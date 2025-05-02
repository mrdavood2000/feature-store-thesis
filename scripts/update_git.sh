#!/usr/bin/env bash
#
# update_git.sh — Check Git version and upgrade to ≥2.40 on Ubuntu
#

set -euo pipefail

REQUIRED_VERSION="2.40.0"

# Function to compare two version strings using dpkg
version_lt() {
  # returns 0 (true) if $1 < $2
  dpkg --compare-versions "$1" lt "$2"
}

echo "Checking installed Git version..."
if ! command -v git &>/dev/null; then
  echo "Git is not installed."
  CURRENT_VERSION="0.0.0"
else
  CURRENT_VERSION=$(git --version | awk '{print $3}')
  echo "Detected Git version: $CURRENT_VERSION"
fi

if version_lt "$CURRENT_VERSION" "$REQUIRED_VERSION"; then
  echo "Git < $REQUIRED_VERSION detected. Upgrading now…"
  sudo add-apt-repository ppa:git-core/ppa -y
  sudo apt-get update
  sudo apt-get install -y git
  echo "Upgrade complete. New Git version: $(git --version | awk '{print $3}')"
else
  echo "Git is already ≥ $REQUIRED_VERSION. No action needed."
fi
