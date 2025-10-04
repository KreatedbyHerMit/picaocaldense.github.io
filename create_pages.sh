#!/bin/bash

# Create homepage
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Picao Caldense - Home</title>
</head>
<body>
    <h1>Welcome to Picao Caldense!</h1>
    <p>I’m Jessica Betancur, the proud President of Picao Caldense. Born into a family with a deep Colombian heritage, I carry forward our tradition of crafting authentic homemade salsa piqué. Passion and family are at the heart of everything we make.</p>
    <p>Our salsa is crafted in Montreal with fresh ingredients, love, and care. Every bottle tells a story — one of culture, warmth, and flavor.</p>
    <nav>
        <a href="index.html">Home</a> |
        <a href="about.html">About</a> |
        <a href="order.html">Order</a>
    </nav>
</body>
</html>
EOL

# Create About page
cat <<EOL > about.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Picao Caldense - About</title>
</head>
<body>
    <h1>About Picao Caldense</h1>
    <p>Growing up as a first-generation Canadian, my life has been a beautiful blend of two worlds. Though I was born and raised in Canada, my heart has always been deeply connected to Colombia—my country of heritage. Embracing my Colombian roots has been my way of honoring my family’s story and culture. Through language, traditions, and stories passed down, I found a bridge between my upbringing and my ancestry.</p>
    <nav>
        <a href="index.html">Home</a> |
        <a href="about.html">About</a> |
        <a href="order.html">Order</a>
    </nav>
</body>
</html>
EOL

# Create Order page
cat <<EOL > order.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Picao Caldense - Order</title>
</head>
<body>
    <h1>Place Your Order</h1>
    <form>
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br><br>
        
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        
        <label for="product">Product:</label><br>
        <select id="product" name="product">
            <option value="classic">Classic Salsa Piqué</option>
            <option value="spicy">Extra Spicy Salsa</option>
            <option value="mild">Mild Salsa</option>
        </select><br><br>
        
        <label for="quantity">Quantity:</label><br>
        <input type="number" id="quantity" name="quantity" min="1" value="1"><br><br>
        
        <input type="submit" value="Submit Order">
    </form>
    <nav>
        <a href="index.html">Home</a> |
        <a href="about.html">About</a> |
        <a href="order.html">Order</a>
    </nav>
</body>
</html>
EOL

echo "Homepage, About page, and Order page created successfully!"
