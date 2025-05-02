#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────
# 1. Ensure ~/.ssh directory exists with proper perms
# ──────────────────────────────────────────────
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# ──────────────────────────────────────────────
# 2. Append GitHub-over-443 config to ~/.ssh/config
# ──────────────────────────────────────────────
cat >> "$HOME/.ssh/config" << 'EOF'
Host github.com
  Hostname ssh.github.com
  Port 443
  User git
  TCPKeepAlive yes
  IdentitiesOnly yes
EOF

chmod 600 "$HOME/.ssh/config"
echo "✅ Wrote SSH config for github.com over port 443."

# ──────────────────────────────────────────────
# 3. Test SSH connection
# ──────────────────────────────────────────────
echo "🧪 Testing SSH → GitHub over port 443..."
ssh -T git@github.com
