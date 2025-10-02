#!/bin/bash

# -----------------------------
# Variables (replace with yours)
# -----------------------------
GITHUB_USER="YOUR_GITHUB_USERNAME"
GITHUB_TOKEN="YOUR_PERSONAL_ACCESS_TOKEN"  # Create at https://github.com/settings/tokens
REPO_NAME="picaocaldense-site"
PROJECT_DIR="/workspaces/Python/PicaoCaldenseSite"

# -----------------------------
# Step 1: Create GitHub repo via API
# -----------------------------
echo "Creating GitHub repository..."
curl -H "Authorization: token $GITHUB_TOKEN" \
     -d "{\"name\":\"$REPO_NAME\",\"private\":false}" \
     https://api.github.com/user/repos

# -----------------------------
# Step 2: Prepare deploy folder
# -----------------------------
cd "$PROJECT_DIR" || exit

# Rename home.html to index.html
if [ -f "home.html" ]; then
    mv home.html index.html
fi

# Make deploy folder
mkdir -p deploy
cp index.html deploy/
cp about.html deploy/
cp order.html deploy/
[ -d "css" ] && cp -r css deploy/
[ -d "images" ] && cp -r images deploy/

cd deploy || exit

# -----------------------------
# Step 3: Initialize Git and push
# -----------------------------
git init
git remote add origin "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
git add .
git commit -m "Initial deploy to GitHub Pages"
git branch -M main
git push -u origin main --force

# -----------------------------
# Step 4: Instructions for GitHub Pages
# -----------------------------
echo
echo "✅ Repository created and code pushed!"
echo "Go to:"
echo "https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
echo "Select branch 'main' and folder '/' to enable GitHub Pages."
echo "Your site will be live at: https://$GITHUB_USER.github.io/$REPO_NAME/"
