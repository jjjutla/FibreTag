@app.route('/items/register', methods=['POST'])
def register_item():
    data = request.json
    nfcUID = data['nfcUID']
    itemName = data['itemName']
    description = data['description']

    # Logic to register item in system and on blockchain

    return jsonify(success=True, itemID=new_item_id, message="Item registered successfully")
