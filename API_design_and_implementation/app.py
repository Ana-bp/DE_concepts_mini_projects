from flask import Flask, jsonify, request, Response, json
from db_utils import get_all_books, get_book_information, book_to_borrow, book_to_return

app = Flask(__name__)

@app.route('/books')
def get_bookings():
    res = get_all_books()
    return jsonify(res)


@app.route('/books/<book_name>')
def get_book_details(book_name):
    res = get_book_information(book_name)
    return Response(json.dumps(res, sort_keys=False), mimetype='application/json')


@app.route('/borrow', methods=['PUT'])
def borrow_book():
    borrowed = request.get_json()
    book_to_borrow(book=borrowed['book_name'])
        
    return borrowed

@app.route('/return', methods=['PUT'])
def return_book():
    returned = request.get_json()
    book_to_return(book=returned['book_name'])
        
    return returned


if __name__ == '__main__':
    app.run(debug=True, port=5001)