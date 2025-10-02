#!/bin/bash

# -------------------------
# Configuration
# -------------------------
GITHUB_USER="KreatedbyHerMit"
REPO_NAME="picaocaldense"
PROJECT_DIR="/workspaces/Python/PicaoCaldenseSite"
CUSTOM_DOMAIN="picaocaldense.com"
OLD_NETLIFY_IP="65.39.166.132"

# -------------------------
# Go to project folder
# -------------------------
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || { echo "Failed to access project folder"; exit 1; }

# -------------------------
# Ensure index.html exists
# -------------------------
if [ ! -f index.html ]; then
cat <<EOL > index.html
<!DOCTYPE html>
<html>
<head>
  <title>Picao Caldense</title>
</head>
<body>
  <h1>Welcome to Picao Caldense!</h1>
</body>
</html>
EOL
echo "Created basic index.html"
fi

# -------------------------
# Initialize git
# -------------------------
git init

# -------------------------
# Commit all files
# -------------------------
git add .
git commit -m "Initial commit for GitHub Pages" || echo "Nothing to commit"

# -------------------------
# Create GitHub repository
# -------------------------
gh repo create "$GITHUB_USER/$REPO_NAME" --public --source=. --remote=origin --push || {
    echo "Failed to create repo. M
