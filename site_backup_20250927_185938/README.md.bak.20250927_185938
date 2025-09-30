
# Python

from flask import Flask, request, render_template, jsonify

app = Flask(__name__)

# In-memory product and orders
products = [
    {"id": 1, "name": "Product A", "price": 10},
    {"id": 2, "name": "Product B", "price": 20}
]

orders = []

@app.route('/')
def home():
    return render_template('index.html', products=products)

@app.route('/place_order', methods=['POST'])
def place_order():
    data = request.get_json()
    order = {
        "name": data["name"],
        "contact": data["contact"],
        "items": data["items"]
    }
    orders.append(order)
    return jsonify({"status": "success", "order_count": len(orders)})

@app.route('/admin/orders')
def view_orders():
    return jsonify(orders)

if __name__ == '__main__':
    app.run(debug=True)
Picao
