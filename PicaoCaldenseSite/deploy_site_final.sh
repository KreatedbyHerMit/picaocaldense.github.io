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
# Initialize git if needed
# -------------------------
git init

# -------------------------
# Add all files and commit
# -------------------------
git add .
git commit -m "Deploy site to GitHub Pages" || echo "Nothing to commit"

# -------------------------
# Set remote and push
# -------------------------
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
git push -u origin main --force || { echo "Push failed. Make sure repo exists and you have access"; exit 1; }

# -------------------------
# Set custom domain
# -------------------------
echo "$CUSTOM_DOMAIN" > CNAME
git add CNAME
git commit -m "Set custom domain" || echo "CNAME already exists"
git push origin main --force

# -------------------------
# Enable GitHub Pages
# -------------------------
gh api -X PUT -H "Accept: application/vnd.github+json" \
/repos/$GITHUB_USER/$REPO_NAME/pages \
-f source.branch='main' -f source.path='/' || { echo "GitHub Pages setup failed"; exit 1; }

# -------------------------
# Verify deployment
# -------------------------
echo "Checking GitHub Pages server..."
curl -sI "https://$CUSTOM_DOMAIN" | grep -i "server"
curl -sI "https://www.$CUSTOM_DOMAIN" | grep -i "server"

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
CURRENT_IP=$(dig +short "$CUSTOM_DOMAIN")
if [[ "$CURRENT_IP" == "$OLD_NETLIFY_IP" ]]; then
    echo "⚠ WARNING: $CUSTOM_DOMAIN still resolves to old Netlify IP ($OLD_NETLIFY_IP)."
    echo "You may need to wait for DNS propagation or check your DNS records."
else
    echo "✅ DNS check passed: $CUSTOM_DOMAIN resolves to $CURRENT_IP (not old Netlify IP)."
fi

echo "✅ Deployment completed. Visit https://$CUSTOM_DOMAIN"
