CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    first_letter CHAR(1) NOT NULL
);


INSERT INTO Books (book_id, book_name, author, first_letter) VALUES
(001, '1984', 'George Orwell', '1'),
(002, 'To Kill a Mockingbird', 'Harper Lee', 'T'),
(003, 'The Great Gatsby', 'F. Scott Fitzgerald', 'T'),
(004, 'One Hundred Years of Solitude', 'Gabriel Garcia Marquez', 'O'),
(005, 'Pride and Prejudice', 'Jane Austen', 'P'),
(006, 'War and Peace', 'Leo Tolstoy', 'W'),
(007, 'The Catcher in the Rye', 'J.D. Salinger', 'T'),
(008, 'Moby Dick', 'Herman Melville', 'M'),
(009, 'The Odyssey', 'Homer', 'T'),
(010, 'Ulysses', 'James Joyce', 'U'),
(011, 'Crime and Punishment', 'Fyodor Dostoevsky', 'C'),
(012, 'The Brothers Karamazov', 'Fyodor Dostoevsky', 'T'),
(013, 'Brave New World', 'Aldous Huxley', 'B'),
(014, 'Anna Karenina', 'Leo Tolstoy', 'A'),
(015, 'The Divine Comedy', 'Dante Alighieri', 'T'),
(016, 'The Hobbit', 'J.R.R. Tolkien', 'T'),
(017, 'The Lord of the Rings', 'J.R.R. Tolkien', 'T'),
(018, 'The Iliad', 'Homer', 'T'),
(019, 'Les Miserables', 'Victor Hugo', 'L'),
(020, 'The Count of Monte Cristo', 'Alexandre Dumas', 'T'),
(021, 'Don Quixote', 'Miguel de Cervantes', 'D'),
(022, 'Madame Bovary', 'Gustave Flaubert', 'M'),
(023, 'Frankenstein', 'Mary Shelley', 'F'),
(024, 'Dracula', 'Bram Stoker', 'D'),
(025, 'The Adventures of Sherlock Holmes', 'Arthur Conan Doyle', 'T'),
(026, 'The Picture of Dorian Gray', 'Oscar Wilde', 'T'),
(027, 'Fahrenheit 451', 'Ray Bradbury', 'F'),
(028, 'The Little Prince', 'Antoine de Saint-Exupéry', 'T'),
(029, 'The Road', 'Cormac McCarthy', 'T'),
(030, 'Slaughterhouse-Five', 'Kurt Vonnegut', 'S');

CREATE TABLE Book_Availability (
    book_id INT PRIMARY KEY,
    available INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Book_Availability (book_id, available) VALUES
(001, FLOOR(RAND() * 10) + 1),
(002, FLOOR(RAND() * 10) + 1),
(003, FLOOR(RAND() * 10) + 1),
(004, FLOOR(RAND() * 10) + 1),
(005, FLOOR(RAND() * 10) + 1),
(006, FLOOR(RAND() * 10) + 1),
(007, FLOOR(RAND() * 10) + 1),
(008, FLOOR(RAND() * 10) + 1),
(009, FLOOR(RAND() * 10) + 1),
(010, FLOOR(RAND() * 10) + 1),
(011, FLOOR(RAND() * 10) + 1),
(012, FLOOR(RAND() * 10) + 1),
(013, FLOOR(RAND() * 10) + 1),
(014, FLOOR(RAND() * 10) + 1),
(015, FLOOR(RAND() * 10) + 1),
(016, FLOOR(RAND() * 10) + 1),
(017, FLOOR(RAND() * 10) + 1),
(018, FLOOR(RAND() * 10) + 1),
(019, FLOOR(RAND() * 10) + 1),
(020, FLOOR(RAND() * 10) + 1),
(021, FLOOR(RAND() * 10) + 1),
(022, FLOOR(RAND() * 10) + 1),
(023, FLOOR(RAND() * 10) + 1),
(024, FLOOR(RAND() * 10) + 1),
(025, FLOOR(RAND() * 10) + 1),
(026, FLOOR(RAND() * 10) + 1),
(027, FLOOR(RAND() * 10) + 1),
(028, FLOOR(RAND() * 10) + 1),
(029, FLOOR(RAND() * 10) + 1),
(030, FLOOR(RAND() * 10) + 1);


CREATE TABLE Book_Details (
    book_id INT PRIMARY KEY,
    publication_year INT,
    pages INT NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Book_Details (book_id, publication_year, pages, description) VALUES
(001, 1949, 328, 'A dystopian novel set in a totalitarian regime where Big Brother watches everyone.'),
(002, 1960, 281, 'A story of racial injustice and loss of innocence in the American South.'),
(003, 1925, 180, 'A novel about the American dream, wealth, and society in the Jazz Age.'),
(004, 1967, 417, 'A magical realist chronicle of seven generations in the Buendía family.'),
(005, 1813, 432, 'A romantic novel about manners, upbringing, morality, and marriage in British society.'),
(006, 1869, 1225, 'An epic novel depicting Russian society during the Napoleonic Wars.'),
(007, 1951, 214, 'A coming-of-age novel following a teenager in post-WWII America.'),
(008, 1851, 585, 'A whaling voyage narrative that explores themes of revenge and obsession.'),
(009, 0, 300, 'An ancient Greek epic poem following the adventures of Odysseus.'),
(010, 1922, 730, 'A modernist novel that parallels Homer\'s Odyssey in Dublin over the course of one day.'),
(011, 1866, 430, 'A psychological drama exploring crime, guilt, and morality in Russia.'),
(012, 1880, 796, 'A philosophical novel that deals with faith, doubt, and free will in a Russian family.'),
(013, 1932, 268, 'A dystopian novel imagining a future society driven by technology and instant gratification.'),
(014, 1877, 864, 'A novel of Russian high society that explores themes of love, family, and infidelity.'),
(015, 1320, 798, 'An epic poem describing Dante\'s journey through Hell, Purgatory, and Heaven.'),
(016, 1937, 310, 'A fantasy novel that introduces the world of Middle-Earth and the journey of Bilbo Baggins.'),
(017, 1954, 1178, 'An epic high-fantasy novel following the quest to destroy the One Ring.'),
(018, 0, 704, 'An ancient Greek epic poem recounting the siege of Troy and the deeds of Achilles.'),
(019, 1862, 1463, 'A historical novel exploring themes of justice, love, and revolution in France.'),
(020, 1844, 1243, 'A tale of revenge and adventure following Edmond Dantès after wrongful imprisonment.'),
(021, 1605, 863, 'A satirical novel about the adventures of a deluded nobleman obsessed with chivalry.'),
(022, 1857, 329, 'A novel about the tragic life of Emma Bovary and her pursuit of romantic ideals.'),
(023, 1818, 280, 'A Gothic novel about a scientist who creates life, leading to disastrous consequences.'),
(024, 1897, 418, 'A Gothic horror novel introducing Count Dracula and the vampire myth.'),
(025, 1892, 307, 'A collection of detective stories featuring the brilliant Sherlock Holmes.'),
(026, 1890, 254, 'A novel about a man who remains forever youthful at the cost of his soul.'),
(027, 1953, 194, 'A dystopian novel about a future society where books are banned and burned.'),
(028, 1943, 96, 'A poetic tale about a young prince who leaves his planet to explore the universe.'),
(029, 2006, 287, 'A post-apocalyptic novel that tells the story of a father and son\'s journey for survival.'),
(030, 1969, 275, 'A satirical novel about the absurdity of war and the experiences of a soldier during WWII.');


