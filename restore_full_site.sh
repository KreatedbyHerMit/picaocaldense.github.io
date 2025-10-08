#!/bin/bash
# FULL RESTORE — Picao Caldense website

# Recreate _layouts folder
mkdir -p _layouts

# Default layout
cat > _layouts/default.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>{{ page.title }}</title>
  <link rel="stylesheet" href="/assets/style.css">
</head>
<body>
  {{ content }}
</body>
</html>
EOL

# Ensure _site exists
mkdir -p _site

# Restore Home page
cat > index.html <<'EOL'
---
layout: default
title: Home
---
<h1>Welcome to Picao Caldense!</h1>
<p>Your Home page content goes here...</p>
EOL

# Restore About page with all your text
cat > about.html <<'EOL'
---
layout: default
title: About
---
<h1>About Picao Caldense</h1>
<p>Welcome to Picao Caldense! I’m Jessica Betancur, the proud President of Picao Caldense. Born into a family with a deep Colombian heritage, I carry forward our tradition of crafting authentic homemade salsa piqué. Passion and family are at the heart of everything we make.</p>
<p>Our salsa is crafted in Montreal with fresh ingredients, love, and care. Every bottle tells a story — one of culture, warmth, and flavor. Growing up as a first-generation Canadian, my life has been a beautiful blend of two worlds. Though I was born and raised in Canada, my heart has always been deeply connected to Colombia—my country of heritage. Embracing my Colombian roots has been my way of honoring my family’s story and culture.</p>
EOL

# Restore Order page
cat > order.html <<'EOL'
---
layout: default
title: Order
---
<h1>Order Picao Caldense</h1>
<p>Your Order page content goes here...</p>
EOL

# Copy all pages to _site
cp index.html about.html order.html _site/

echo "✅ Full site restored! Check the _site folder."
