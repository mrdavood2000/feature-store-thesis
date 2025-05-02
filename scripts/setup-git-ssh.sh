#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────
# 1. Configure your Git identity
# ──────────────────────────────────────────────
read -p "Enter your Git user.name (e.g. Your Name): " GIT_USER_NAME
read -p "Enter your Git user.email (e.g. you@example.com): " GIT_USER_EMAIL

git config --global user.name  "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

echo "✅ Git global user.name and user.email set."

# ──────────────────────────────────────────────
# 2. Generate an ED25519 SSH key (if not present)
# ──────────────────────────────────────────────
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
  echo "🔑 SSH key already exists at $SSH_KEY"
else
  ssh-keygen -t ed25519 \
             -C "$GIT_USER_EMAIL" \
             -f "$SSH_KEY" \
             -N "" \
             -q
  echo "✅ Generated new SSH key at $SSH_KEY"
fi

# ──────────────────────────────────────────────
# 3. Start ssh-agent & add your key
# ──────────────────────────────────────────────
echo "🕵️  Starting ssh-agent..."
eval "$(ssh-agent -s)" >/dev/null
ssh-add "$SSH_KEY"
echo "✅ Added SSH key to ssh-agent."

# ──────────────────────────────────────────────
# 4. Show your public key for GitHub
# ──────────────────────────────────────────────
echo
echo "═════════════════════════════════════════════════════"
echo " Copy everything below and add it as an SSH key on GitHub:"
echo
cat "${SSH_KEY}.pub"
echo "═════════════════════════════════════════════════════"
echo "▷ Go to https://github.com/settings/ssh/new to paste it."
echo

# ──────────────────────────────────────────────
# 5. Test your SSH connection
# ──────────────────────────────────────────────
echo "🧪 Testing connection to GitHub..."
ssh -T git@github.com || {
  echo "⚠️  SSH test failed—make sure you’ve added the key to GitHub."
  exit 1
}
echo "✅ SSH connection to GitHub successful!"
