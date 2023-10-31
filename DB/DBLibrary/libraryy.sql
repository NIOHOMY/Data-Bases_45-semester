-- Создание схемы данных (если отсутствует)
CREATE SCHEMA IF NOT EXISTS library_schema AUTHORIZATION your_login;
COMMENT ON SCHEMA library_schema IS 'Схема данных для библиотеки';

-- Установка search_path для текущей сессии
/*ALTER ROLE you_login IN DATABASE your_db */
SET search_path TO library_schema, public;


-- Удаление таблиц
/*
DROP TABLE IF EXISTS issuebook;

DROP TABLE IF EXISTS issues;

DROP TABLE IF EXISTS readers;

DROP TABLE IF EXISTS books;

DROP TABLE IF EXISTS publishers;

DROP TABLE IF EXISTS authors;
*/

-- Проверка 
/*
SELECT * FROM authors;
SELECT * FROM publishers;
SELECT * FROM books;
SELECT * FROM readers;
SELECT * FROM issues;
SELECT * FROM issuebook;
*/

-- Создание таблицы publishers

CREATE TABLE IF NOT EXISTS publishers (
	publisher_id serial NOT NULL,
	name_of_publisher TEXT NOT NULL,
	city TEXT NOT NULL,
	CONSTRAINT publishers_pk PRIMARY KEY (publisher_id)
) WITH (OIDS=FALSE);
-- Инструкции для таблицы publishers
COMMENT ON TABLE publishers IS 'Издательства';
COMMENT ON COLUMN publishers.publisher_id IS 'ID издательства';
COMMENT ON COLUMN publishers.name_of_publisher IS 'Название издательства';
COMMENT ON COLUMN publishers.city IS 'Город издательства';


-- Создание таблицы books

CREATE TABLE IF NOT EXISTS books (
	book_id serial NOT NULL,
	title_book TEXT NOT NULL,
	first_author_id int NOT NULL,
	year_of_publication int NOT NULL,
	price_books numeric NOT NULL CHECK (price_books >= 0),
	number_of_examples int NOT NULL,
	publisher_id int NOT NULL,
	CONSTRAINT books_pk PRIMARY KEY (book_id)
) WITH (OIDS=FALSE);
-- Инструкции для таблицы books
COMMENT ON TABLE books IS 'Книги';
COMMENT ON COLUMN books.book_id IS 'ID книги';
COMMENT ON COLUMN books.title_book IS 'Название книги';
COMMENT ON COLUMN books.first_author_id IS 'ID первого автора';
COMMENT ON COLUMN books.year_of_publication IS 'Год издания';
COMMENT ON COLUMN books.price_books IS 'Стоимость книги';
COMMENT ON COLUMN books.number_of_examples IS 'Количество экземпляров';
COMMENT ON COLUMN books.publisher_id IS 'ID издательства';


-- Создание таблицы readers

CREATE TABLE IF NOT EXISTS readers (
	reader_id serial NOT NULL,
	reader_full_name TEXT NOT NULL,
	address TEXT NOT NULL,
	phone_number TEXT NOT NULL,
	CONSTRAINT readers_pk PRIMARY KEY (reader_id)
) WITH (OIDS=FALSE);
-- Инструкции для таблицы readers
COMMENT ON TABLE readers IS 'Читатели';
COMMENT ON COLUMN readers.reader_id IS 'ID читателя';
COMMENT ON COLUMN readers.reader_full_name IS 'ФИО читателя';
COMMENT ON COLUMN readers.address IS 'Адрес читателя';
COMMENT ON COLUMN readers.phone_number IS 'Номер телефона читателя';


-- Создание таблицы issues

CREATE TABLE IF NOT EXISTS issues (
	issue_id serial NOT NULL,
	issue_date TIMESTAMP NOT NULL,
	return_date TIMESTAMP NOT NULL,
	reader_id int NOT NULL,
	CONSTRAINT issues_pk PRIMARY KEY (issue_id)
) WITH (OIDS=FALSE);
-- Инструкции для таблицы issues
COMMENT ON TABLE issues IS 'Выдачи книг';
COMMENT ON COLUMN issues.issue_id IS 'ID выдачи';
COMMENT ON COLUMN issues.issue_date IS 'Дата выдачи';
COMMENT ON COLUMN issues.return_date IS 'Дата возврата';
COMMENT ON COLUMN issues.reader_id IS 'ID читателя';


-- Создание таблицы issuebook

CREATE TABLE IF NOT EXISTS issuebook (
	id serial NOT NULL,
	book_id int NOT NULL,
	issue_id int NOT NULL,
	CONSTRAINT issuebook_pk PRIMARY KEY (id)
) WITH (OIDS=FALSE);
-- Инструкции для таблицы issuebook
COMMENT ON TABLE issuebook IS 'Связь между книгами и выдачами';
COMMENT ON COLUMN issuebook.id IS 'ID связи';
COMMENT ON COLUMN issuebook.book_id IS 'ID книги';
COMMENT ON COLUMN issuebook.issue_id IS 'ID выдачи';


-- Создание таблицы authors

CREATE TABLE IF NOT EXISTS authors (
	author_id serial NOT NULL,
	authot_name TEXT NOT NULL,
	CONSTRAINT authors_pk PRIMARY KEY (author_id)
) WITH (OIDS=FALSE);
-- Инструкции для таблицы authors
COMMENT ON TABLE authors IS 'Авторы';
COMMENT ON COLUMN authors.author_id IS 'ID автора';
COMMENT ON COLUMN authors.authot_name IS 'Имя автора';

-- Связи таблиц
ALTER TABLE books 
	  ADD CONSTRAINT books_fk_author_id FOREIGN KEY (first_author_id) 
	  REFERENCES authors(author_id)
	  ON UPDATE CASCADE;
ALTER TABLE books 
	  ADD CONSTRAINT books_fk_publisher_id FOREIGN KEY (publisher_id) 
	  REFERENCES publishers(publisher_id)
	  ON UPDATE CASCADE;


ALTER TABLE issues 
	  ADD CONSTRAINT issues_fk_reader_id FOREIGN KEY (reader_id) 
	  REFERENCES readers(reader_id)
	  ON UPDATE CASCADE;

ALTER TABLE issuebook 
	  ADD CONSTRAINT issuebook_fk_book_id FOREIGN KEY (book_id) 
	  REFERENCES books(book_id)
	  ON UPDATE CASCADE;
ALTER TABLE issuebook 
	  ADD CONSTRAINT issuebook_fk_issue_id FOREIGN KEY (issue_id) 
	  REFERENCES issues(issue_id)
	  ON UPDATE CASCADE
	  ON DELETE CASCADE;





-- Таблица authors:

INSERT INTO authors (authot_name) VALUES ('Лев Толстой');
INSERT INTO authors (authot_name) VALUES ('Федор Достоевский');
INSERT INTO authors (authot_name) VALUES ('Марк Твен');
INSERT INTO authors (authot_name) VALUES ('Антуан де Сент-Экзюпери');
INSERT INTO authors (authot_name) VALUES ('Джордж Оруэлл');

-- Таблица publishers:

INSERT INTO publishers (name_of_publisher, city) VALUES ('ACT', 'Москва');
INSERT INTO publishers (name_of_publisher, city) VALUES ('O Reilly Media', 'Сан-Франциско');
INSERT INTO publishers (name_of_publisher, city) VALUES ('Penguin Random House', 'Лондон');
INSERT INTO publishers (name_of_publisher, city) VALUES ('HarperCollins Publishers', 'Нью-Йорк');
INSERT INTO publishers (name_of_publisher, city) VALUES ('Bloomsbury Publishing', 'Лондон');

-- Таблица books:

INSERT INTO books (title_book, first_author_id, year_of_publication, price_books, number_of_examples, publisher_id) VALUES ('Война и мир', 1, 1869, 25.5, 100, 1);
INSERT INTO books (title_book, first_author_id, year_of_publication, price_books, number_of_examples, publisher_id) VALUES ('Преступление и наказание', 2, 1866, 20.8, 75, 2);
INSERT INTO books (title_book, first_author_id, year_of_publication, price_books, number_of_examples, publisher_id) VALUES ('Приключения Тома Сойера', 3, 1876, 15.2, 50, 3);
INSERT INTO books (title_book, first_author_id, year_of_publication, price_books, number_of_examples, publisher_id) VALUES ('Маленький принц', 4, 1943, 10.5, 150, 4);
INSERT INTO books (title_book, first_author_id, year_of_publication, price_books, number_of_examples, publisher_id) VALUES ('1984', 5, 1949, 12.7, 80, 5);

-- Таблица readers:

INSERT INTO readers (reader_full_name, address, phone_number) VALUES ('Иванов Иван Иванович', 'ул. Пушкина, д. 1, кв. 10', '8-800-555-35-35');
INSERT INTO readers (reader_full_name, address, phone_number) VALUES ('Петров Петр Петрович', 'ул. Лермонтова, д. 5, кв. 20', '8-800-555-34-34');
INSERT INTO readers (reader_full_name, address, phone_number) VALUES ('Сидоров Сидор Сидорович', 'ул. Гоголя, д. 3, кв. 15', '8-800-555-33-33');
INSERT INTO readers (reader_full_name, address, phone_number) VALUES ('Кузнецов Кузьма Кузьмич', 'ул. Толстого, д. 11, кв. 30', '8-800-555-32-32');
INSERT INTO readers (reader_full_name, address, phone_number) VALUES ('Новикова Анна Владимировна', 'ул. Пушкина, д. 2, кв. 5', '8-800-555-31-31');

-- Таблица issues:

INSERT INTO issues (issue_date, return_date, reader_id) VALUES ('2023-10-20 10:00:00', '2023-10-22 18:00:00', 1);
INSERT INTO issues (issue_date, return_date, reader_id) VALUES ('2023-10-21 11:00:00', '2023-10-28 18:00:00', 2);
INSERT INTO issues (issue_date, return_date, reader_id) VALUES ('2023-10-22 12:00:00', '2023-10-29 18:00:00', 3);
INSERT INTO issues (issue_date, return_date, reader_id) VALUES ('2023-10-23 13:00:00', '2023-10-25 18:00:00', 4);
INSERT INTO issues (issue_date, return_date, reader_id) VALUES ('2023-10-24 14:00:00', '2023-10-31 18:00:00', 5);

-- Таблица issuebook:

INSERT INTO issuebook (book_id, issue_id) VALUES (1, 1);
INSERT INTO issuebook (book_id, issue_id) VALUES (2, 2);
INSERT INTO issuebook (book_id, issue_id) VALUES (3, 3);
INSERT INTO issuebook (book_id, issue_id) VALUES (4, 4);
INSERT INTO issuebook (book_id, issue_id) VALUES (5, 5);