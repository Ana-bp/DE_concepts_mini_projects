from flask import Flask, jsonify, request

from db_utils import get_all_booking_availability, add_booking

app = Flask(__name__)


# get availability information
@app.route('/availability/<date>')
def get_bookings(date):
    res = get_all_booking_availability(date)
    return jsonify(res)


@app.route('/booking', methods=['PUT'])
def book_apt():
    booking = request.get_json()
    add_booking(
        date=booking['date'],
        teamMember=booking['teamMember'],
        time=booking['time'],
        customer=booking['customer']
    )
    return booking


if __name__ == '__main__':
    app.run(debug=True, port=5001)