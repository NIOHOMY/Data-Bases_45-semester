-- Создание схемы данных (если отсутствует)
/*
CREATE SCHEMA IF NOT EXISTS library_schema AUTHORIZATION pakhomova_pv;
COMMENT ON SCHEMA library_schema IS 'Схема данных для библиотеки';
*/

-- Установка search_path для текущей сессии
/*
*/
ALTER ROLE pakhomova_pv IN DATABASE pakhomova_pv_db 
SET search_path TO library_schema, public;


-- Удаление таблиц
/*
DROP TABLE IF EXISTS issuebook;

DROP TABLE IF EXISTS issues;

DROP TABLE IF EXISTS readers;

DROP TABLE IF EXISTS user_accounts;

DROP TABLE IF EXISTS books;

DROP TABLE IF EXISTS publishers;

DROP TABLE IF EXISTS authors;
*/

-- Проверка 
/*
SELECT * FROM authors;
SELECT * FROM publishers;
SELECT * FROM books;
SELECT * FROM user_accounts;
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
    price numeric NOT NULL CHECK (price >= 0.01),
    number_of_examples int NOT NULL CHECK (number_of_examples >= 0),
    image_data bytea,
    info TEXT,
    publisher_id int NOT NULL,
	CONSTRAINT books_pk PRIMARY KEY (book_id)
) WITH (OIDS=FALSE);
-- Инструкции для таблицы books
COMMENT ON TABLE books IS 'Книги';
COMMENT ON COLUMN books.book_id IS 'ID книги';
COMMENT ON COLUMN books.title_book IS 'Название книги';
COMMENT ON COLUMN books.first_author_id IS 'ID первого автора';
COMMENT ON COLUMN books.year_of_publication IS 'Год издания';
COMMENT ON COLUMN books.price IS 'Стоимость книги';
COMMENT ON COLUMN books.number_of_examples IS 'Количество экземпляров';
COMMENT ON COLUMN books.publisher_id IS 'ID издательства';
COMMENT ON COLUMN books.image_data IS 'Обложка книги';
COMMENT ON COLUMN books.info IS 'Описание книги';


-- Создание таблицы readers

CREATE TABLE IF NOT EXISTS readers (
    reader_id serial NOT NULL,
    email TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    patronymic TEXT DEFAULT '',
    address TEXT NOT NULL,
    phone_number TEXT NOT NULL,
	
    CONSTRAINT readers_pk PRIMARY KEY (reader_id)
) WITH (OIDS=FALSE);

-- Инструкции для таблицы readers
COMMENT ON TABLE readers IS 'Читатели';
COMMENT ON COLUMN readers.reader_id IS 'ID читателя';
COMMENT ON COLUMN readers.first_name IS 'Имя читателя';
COMMENT ON COLUMN readers.last_name IS 'Фамилия читателя';
COMMENT ON COLUMN readers.patronymic IS 'Отчество читателя';
COMMENT ON COLUMN readers.address IS 'Адрес читателя';
COMMENT ON COLUMN readers.phone_number IS 'Номер телефона читателя';
COMMENT ON COLUMN readers.email IS 'Email/Логин читателя';

CREATE TABLE IF NOT EXISTS user_accounts (
    user_id serial NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL,
    CONSTRAINT user_accounts_pk PRIMARY KEY (user_id),
    CONSTRAINT user_accounts_email_unique UNIQUE (email)   
) WITH (OIDS=FALSE);
-- Инструкции для таблицы readers
COMMENT ON TABLE user_accounts IS 'Пользователи';
COMMENT ON COLUMN user_accounts.user_id IS 'ID пользователя';
COMMENT ON COLUMN user_accounts.email IS 'Логин пользователя';
COMMENT ON COLUMN user_accounts.password_hash IS 'Хеш пароль пользователя';
COMMENT ON COLUMN user_accounts.role IS 'Роль пользователя';

-- Создание таблицы issues

CREATE TABLE IF NOT EXISTS issues (
	issue_id serial NOT NULL,
	issue_date TIMESTAMP NOT NULL,
	return_date TIMESTAMP NOT NULL,
	is_confirmed BOOLEAN DEFAULT FALSE,
	reader_id int NOT NULL,
	price decimal NOT NULL DEFAULT 0,
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
    image_data bytea,
    info TEXT,
    author_name TEXT NOT NULL,
    CONSTRAINT authors_pk PRIMARY KEY (author_id)
) WITH (OIDS=FALSE);

-- Инструкции для таблицы authors
COMMENT ON TABLE authors IS 'Авторы';
COMMENT ON COLUMN authors.author_id IS 'ID автора';
COMMENT ON COLUMN authors.author_name IS 'Имя автора';
COMMENT ON COLUMN authors.image_data IS 'Портрет автора';
COMMENT ON COLUMN authors.info IS 'Биография/иная информация об авторе';

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

INSERT INTO authors (author_name) VALUES ('Лев Толстой');
INSERT INTO authors (author_name) VALUES ('Федор Достоевский');
INSERT INTO authors (author_name) VALUES ('Марк Твен');
INSERT INTO authors (author_name) VALUES ('Антуан де Сент-Экзюпери');
INSERT INTO authors (author_name) VALUES ('Джордж Оруэлл');

-- Таблица publishers:

INSERT INTO publishers (name_of_publisher, city) VALUES ('ACT', 'Москва');
INSERT INTO publishers (name_of_publisher, city) VALUES ('O Reilly Media', 'Сан-Франциско');
INSERT INTO publishers (name_of_publisher, city) VALUES ('Penguin Random House', 'Лондон');
INSERT INTO publishers (name_of_publisher, city) VALUES ('HarperCollins Publishers', 'Нью-Йорк');
INSERT INTO publishers (name_of_publisher, city) VALUES ('Bloomsbury Publishing', 'Лондон');

-- Таблица books:

INSERT INTO books (title_book, first_author_id, year_of_publication, price, number_of_examples, publisher_id) VALUES ('Война и мир', 1, 1869, 25.5, 100, 1);
INSERT INTO books (title_book, first_author_id, year_of_publication, price, number_of_examples, publisher_id) VALUES ('Преступление и наказание', 2, 1866, 20.8, 75, 2);
INSERT INTO books (title_book, first_author_id, year_of_publication, price, number_of_examples, publisher_id) VALUES ('Приключения Тома Сойера', 3, 1876, 15.2, 50, 3);
INSERT INTO books (title_book, first_author_id, year_of_publication, price, number_of_examples, publisher_id) VALUES ('Маленький принц', 4, 1943, 10.5, 150, 4);
INSERT INTO books (title_book, first_author_id, year_of_publication, price, number_of_examples, publisher_id) VALUES ('1984', 5, 1949, 12.7, 80, 5);

-- Таблица user_accounts:

INSERT INTO user_accounts (email, password_hash, role)
VALUES ('ivanov@e.com', 'hashPassword1', 'user');

INSERT INTO user_accounts (email, password_hash, role)
VALUES ('petrov@e.com', 'hashPassword2', 'user');

INSERT INTO user_accounts (email, password_hash, role)
VALUES ('sidorov@e.com', 'hashPassword3', 'user');

INSERT INTO user_accounts (email, password_hash, role)
VALUES ('kuznetsov@e.com', 'hashPassword4', 'user');

INSERT INTO user_accounts (email, password_hash, role)
VALUES ('novikova@e.com', 'hashPassword5', 'user');
-- Таблица readers:

INSERT INTO readers (email, first_name, last_name, patronymic, address, phone_number)
VALUES ('ivanov@e.com', 'Иван', 'Иванов', 'Иванович', 'ул. Пушкина, д. 1, кв. 10', '8-800-555-35-35');

INSERT INTO readers (email, first_name, last_name, patronymic, address, phone_number)
VALUES ('petrov@e.com', 'Петр', 'Петров', 'Петрович', 'ул. Лермонтова, д. 5, кв. 20', '8-800-555-34-34');

INSERT INTO readers (email, first_name, last_name, patronymic, address, phone_number)
VALUES ('sidorov@e.com', 'Сидор', 'Сидоров', 'Сидорович', 'ул. Гоголя, д. 3, кв. 15', '8-800-555-33-33');

INSERT INTO readers (email, first_name, last_name, patronymic, address, phone_number)
VALUES ('kuznetsov@e.com', 'Кузьма', 'Кузнецов', 'Кузьмич', 'ул. Толстого, д. 11, кв. 30', '8-800-555-32-32');

INSERT INTO readers (email, first_name, last_name, patronymic, address, phone_number)
VALUES ('novikova@e.com', 'Анна', 'Новикова', 'Владимировна', 'ул. Пушкина, д. 2, кв. 5', '8-800-555-31-31');




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
