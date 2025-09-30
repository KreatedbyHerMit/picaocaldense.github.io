#!/bin/bash
set -e

# Path to your site files
DEPLOY_DIR="/workspaces/Python/deploy_ready"

# Your Netlify site ID
NETLIFY_SITE="cool-longma-8779c7"

# Your Netlify personal access token
export NETLIFY_AUTH_TOKEN="nfp_rvtbQWFJLg4XS3CGHbzUj9LpW3mUAnPY90d9"

# Ensure deploy directory exists
if [ ! -d "$DEPLOY_DIR" ]; then
  echo "❌ Deploy folder does not exist: $DEPLOY_DIR"
  exit 1
fi

# Install Netlify CLI if not installed
npm install -g netlify-cli

# Deploy non-interactively
netlify deploy --dir="$DEPLOY_DIR" --prod --site "$NETLIFY_SITE" --auth "$NETLIFY_AUTH_TOKEN"

echo "✅ Site deployed successfully to Netlify!"
