import json
import requests


def get_availability_by_date(date):
    result = requests.get(f'http://127.0.0.1:5001/availability/{date}')
    return result.json()


def add_booking(date, teamMember, time, customer):
    booking = {
        "date": date,
        "teamMember": teamMember,
        "time": time,
        "customer": customer
    }
    result = requests.put(
        'http:127.0.0.1:5001/booking',
        headers={'content-type': 'application/json'},
        data=json.dumps(booking)
    )
    return result.json()


def display_availability(records):
    # Print the names of the columns.
    print("{:<15} {:<15} {:<15} {:<15} {:<15} {:<15} {:<15} ".format(
        'NAME', '12-13', '13-14', '14-15', '15-16', '16-17', '17-18'))
    print('-' * 105)

    # print each data item.
    for item in records:
        print("{:<15} {:<15} {:<15} {:<15} {:<15} {:<15} {:<15} ".format(
            item['name'], item['12-13'], item['13-14'], item['14-15'], item['15-16'], item['16-17'], item['17-18']
        ))

def run():
    print('############################')
    print('Hello, welcome to our salon')
    print('############################')
    print()
    date = input('What date would you like your appointment for (YYYY-MM-DD): ')
    print()
    print('####### AVAILABILITY #######')
    print()
    slots = get_availability_by_date(date)
    print(display_availability(slots))
    place_booking = input('Would you like to book an appointment (y/n)?  ').lower()
    book = place_booking == 'y'

    if book:
        cust = input('Enter your name: ')
        stylist = input('Who would you like to book with?: ')
        time = input('Choose your available time slot (eg 13-14): ')
        add_booking(date=date,teamMember=stylist, time=time, customer=cust)
        print('Booking Successful')
        slots = get_availability_by_date(date)
        print(display_availability(slots))
    print()
    print('See you soon!')

if __name__ == '__main__':
    run()