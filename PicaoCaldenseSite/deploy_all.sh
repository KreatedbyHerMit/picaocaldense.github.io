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
# Create GitHub repository if it does not exist
# -------------------------
if ! gh repo view "$GITHUB_USER/$REPO_NAME" >/dev/null 2>&1; then
    echo "Creating repository $GITHUB_USER/$REPO_NAME ..."
    gh repo create "$GITHUB_USER/$REPO_NAME" --public --source=. --remote=origin --push || {
        echo "Failed to create repo. Check GitHub CLI login and token permissions."
        exit 1
    }
else
    echo "Repository already exists, setting remote origin ..."
    git remote remove origin 2>/dev/null
    git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
fi

# -------------------------
# Set custom domain
# -------------------------
echo "$CUSTOM_DOMAIN" > CNAME
git add CNAME
git commit -m "Set custom domain" || echo "CNAME already committed"
git push origin main --force

# -------------------------
# Enable GitHub Pages
# -------------------------
gh api -X PUT -H "Accept: application/vnd.github+json" \
/repos/$GITHUB_USER/$REPO_NAME/pages \
-f source.branch='main' -f source.path='/' || { echo "GitHub Pages setup failed"; exit 1; }

# -------------------------
# Flush Mac DNS cache
# -------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Flushing Mac DNS cache..."
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo "DNS cache flushed on Mac."
fi

# -------------------------
# Check for old Netlify IP
# -------------------------
if command -v dig >/dev/null 2>&1; then
    CURRENT_IP=$(dig +short "$CUSTOM_DOMAIN")
else
    CURRENT_IP=$(curl -s https://$CUSTOM_DOMAIN --connect-timeout 5 -I | grep -i "server")
fi

if [[ "$CURRENT_IP" == "$OLD_NETLIFY_IP" ]]; then
    echo "⚠ WARNING: $CUSTOM_DOMAIN still resolves to old Netlify IP ($OLD_NETLIFY_IP)."
else
    echo "✅ DNS check passed: $CUSTOM_DOMAIN resolves correctly."
fi

# -------------------------
# Verify server
# -------------------------
echo "Checking GitHub Pages server..."
curl -sI "https://$CUSTOM_DOMAIN" | grep -i "server"
curl -sI "https://www.$CUSTOM_DOMAIN" | grep -i "server"

echo "✅ Deployment completed! Visit https://$CUSTOM_DOMAIN"
