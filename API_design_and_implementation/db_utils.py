import mysql.connector
from config import HOST, USER, PASSWORD


class DbConnectionError(Exception):
    pass


def _connect_to_db(db_name):
    return mysql.connector.connect(
        host=HOST,
        user=USER,
        password=PASSWORD,
        auth_plugin='mysql_native_password',
        database=db_name
    )

def _map_details(books):
    mapped = []
    for item in books:
        mapped.append({
            'Book ID': item[0],
            'Name': item[1],
            'Author': item[2],
            'Publication year': item[3],
            'Total pages': item[4],
            'Description': item[5],
        })
    return mapped

def _map_books(books):
    mapped = []
    for item in books:
        mapped.append({
            'Book name': item[0],
            'Copies available': item[1],
        })
    return mapped


def get_book_information(book_name):
    book_details = []
    try:
        db_name = 'LibraryDB'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print(f"Connected to DB: {db_name}")

        query = """
        SELECT b.book_id, b.book_name, b.author, bd.publication_year, bd.pages, bd.description
        FROM Books b
        JOIN Book_Details bd ON b.book_id = bd.book_id
        WHERE b.book_name = '{}'
        """.format(book_name)
        

        cur.execute(query)
        result = cur.fetchall()
        book_details = _map_details(result)
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to read data from DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

    return book_details

def get_all_books():
    books = []
    try:
        db_name = 'LibraryDB'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print(f"Connected to DB: {db_name}")

        query = """
        SELECT b.book_name, ba.available
        FROM Books b
        JOIN Book_Availability ba ON b.book_id = ba.book_id
        """

        cur.execute(query)
        result = cur.fetchall()
        books = _map_books(result)
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to read data from DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

    return books


def book_to_borrow(book):
    try:
        db_name = 'LibraryDB'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print(f"Connected to DB: {db_name}")
        query = """
            UPDATE Book_Availability ba
            JOIN Books b ON ba.book_id = b.book_id
            SET
                ba.available = ba.available-1
                WHERE b.book_name = '{book}'
            """.format(book=book)


        cur.execute(query)
        db_connection.commit()
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to read data from DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

def book_to_return(book):
    try:
        db_name = 'LibraryDB'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print(f"Connected to DB: {db_name}")
        query = """
            UPDATE Book_Availability ba
            JOIN Books b ON ba.book_id = b.book_id
            SET
                ba.available = ba.available+1
                WHERE b.book_name = '{book}'
            """.format(book=book)

        cur.execute(query)
        db_connection.commit()
        cur.close()

    except Exception:
        raise DbConnectionError("Failed to read data from DB")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

