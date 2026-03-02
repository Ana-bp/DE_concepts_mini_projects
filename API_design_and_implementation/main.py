import json
import requests

def get_book_list():
    result = requests.get('http://127.0.0.1:5001/books')
    return result.json()


def get_book_details(book_name):
    result = requests.get(f'http://127.0.0.1:5001/books/{book_name}')
    return result.json()

def borrow(book_name):
    option={'book_name':book_name,}
    result = requests.put(
        'http://127.0.0.1:5001/borrow',
        headers={'content-type': 'application/json'},
        data=json.dumps(option)
    )
    return result.json()

def returned(book_name):
    option={'book_name':book_name}
    result = requests.put(
        'http://127.0.0.1:5001/return',
        headers={'content-type': 'application/json'},
        data=json.dumps(option)
    )
    return result.json()




def run():
    print('Welcome to the Library system\n\n')
    service = input('Which service are you looking for:\n1. Books available\n2. Book information\n3. Borrow a book\n4. Return a book\n\nService: ')
    print('############################')
    print()
    if service =='1':
        records =get_book_list()
        print("{:<40} {:<15} ".format('Book', 'Copies available'))
        print('-' * 55)
        for item in records:
            print("{:<40} {:<15} ".format(
            item['Book name'], item['Copies available']))
    elif service =='2':
        book = input('Name of the book: ')
        print(get_book_details(book))
    elif service =='3':
        book = input("What is the book you want to borrow: ")
        borrow(book)
        print("The book was borrowed successfully!")
    elif service =='4':
        book = input("What is the book you want to return: ")
        returned(book)
        print("The book was returned successfully!")



if __name__ == '__main__':
    run()