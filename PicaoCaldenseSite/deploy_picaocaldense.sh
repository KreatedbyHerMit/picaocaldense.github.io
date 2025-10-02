#!/bin/bash

# -------------------------
# Configuration
# -------------------------
GITHUB_USER="KreatedbyHerMit"
REPO_NAME="picaocaldense"
PROJECT_DIR="/workspaces/Python/PicaoCaldenseSite"
CUSTOM_DOMAIN="picaocaldense.com"

# -------------------------
# Ask for GitHub PAT
# -------------------------
read -sp "Enter your GitHub PAT (with 'repo' scope): " GITHUB_PAT
echo

# -------------------------
# Go to project folder
# -------------------------
cd "$PROJECT_DIR" || { echo "Project folder not found"; exit 1; }

# -------------------------
# Add CNAME for custom domain
# -------------------------
echo "$CUSTOM_DOMAIN" > CNAME

# -------------------------
# Stage all files
# -------------------------
git add .

# -------------------------
# Commit changes
# -------------------------
git commit -m "Deploy site to GitHub Pages root" || echo "Nothing to commit"

# -------------------------
# Set remote with PAT
# -------------------------
git remote remove origin 2>/dev/null
git remote add origin "https://$GITHUB_USER:$GITHUB_PAT@github.com/$GITHUB_USER/$REPO_NAME.git"

# -------------------------
# Push all files to main
# -------------------------
echo "Pushing to GitHub..."
git push -u origin main --force || { echo "Push failed. Check PAT and repo permissions."; exit 1; }

# -------------------------
# Enable GitHub Pages from main branch root
# -------------------------
echo "Enabling GitHub Pages..."
gh api -X PUT -H "Accept: application/vnd.github+json" \
  /repos/$GITHUB_USER/$REPO_NAME/pages \
  -f source.branch='main' -f source.path='/' || { echo "GitHub Pages setup failed"; exit 1; }

# -------------------------
# Verify deployment
# -------------------------
echo "Checking server..."
curl -sI "https://$CUSTOM_DOMAIN" | grep -i "server"

echo "Deployment complete! Visit: https://$CUSTOM_DOMAIN"
