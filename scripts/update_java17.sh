#!/usr/bin/env bash
#
# update_java17.sh — Check Java version and install OpenJDK 17 on Ubuntu if needed
#

set -euo pipefail

REQUIRED_VERSION="17.0.0"

# Compare two dpkg-style version strings: returns true if $1 < $2
version_lt() {
  dpkg --compare-versions "$1" lt "$2"
}

echo "Checking for Java installation..."
if command -v java &>/dev/null; then
  # Extract full version string, e.g. "17.0.7"
  CURRENT_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
  echo "Detected Java version: $CURRENT_VERSION"
else
  echo "Java not found."
  CURRENT_VERSION="0.0.0"
fi

if version_lt "$CURRENT_VERSION" "$REQUIRED_VERSION"; then
  echo "Java version is older than $REQUIRED_VERSION. Installing OpenJDK 17…"
  sudo apt-get update
  sudo apt-get install -y openjdk-17-jdk
  NEW_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
  echo "Installation complete. Now running Java $NEW_VERSION"
else
  echo "Java is already $CURRENT_VERSION (≥ $REQUIRED_VERSION). No action needed."
fi
