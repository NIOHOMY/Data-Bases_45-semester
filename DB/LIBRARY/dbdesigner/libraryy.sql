-- Инструкции для таблицы publishers
COMMENT ON TABLE publishers IS 'Издательства';
COMMENT ON COLUMN publishers.publisher_id IS 'ID издательства';
COMMENT ON COLUMN publishers.name_of_publisher IS 'Название издательства';
COMMENT ON COLUMN publishers.city IS 'Город издательства';
-- Создание таблицы publishers

CREATE TABLE IF NOT EXISTS publishers (
	publisher_id serial NOT NULL,
	name_of_publisher TEXT NOT NULL,
	city TEXT NOT NULL,
	CONSTRAINT publishers_pk PRIMARY KEY (publisher_id)
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
-- Создание таблицы books

CREATE TABLE IF NOT EXISTS books (
	book_id serial NOT NULL,
	title_book TEXT NOT NULL,
	first_author_id int NOT NULL,
	year_of_publication int NOT NULL,
	price_books numeric NOT NULL,
	number_of_examples int NOT NULL,
	publisher_id int NOT NULL,
	CONSTRAINT books_pk PRIMARY KEY (book_id)
) WITH (OIDS=FALSE);


-- Инструкции для таблицы readers
COMMENT ON TABLE readers IS 'Читатели';
COMMENT ON COLUMN readers.reader_id IS 'ID читателя';
COMMENT ON COLUMN readers.reader_full_name IS 'ФИО читателя';
COMMENT ON COLUMN readers.address IS 'Адрес читателя';
COMMENT ON COLUMN readers.phone_number IS 'Номер телефона читателя';
-- Создание таблицы readers

CREATE TABLE IF NOT EXISTS readers (
	reader_id serial NOT NULL,
	reader_full_name TEXT NOT NULL,
	address TEXT NOT NULL,
	phone_number TEXT NOT NULL,
	CONSTRAINT readers_pk PRIMARY KEY (reader_id)
) WITH (OIDS=FALSE);


-- Инструкции для таблицы issues
COMMENT ON TABLE issues IS 'Выдачи книг';
COMMENT ON COLUMN issues.issue_id IS 'ID выдачи';
COMMENT ON COLUMN issues.issue_date IS 'Дата выдачи';
COMMENT ON COLUMN issues.return_date IS 'Дата возврата';
COMMENT ON COLUMN issues.reader_id IS 'ID читателя';
-- Создание таблицы issues

CREATE TABLE IF NOT EXISTS issues (
	issue_id serial NOT NULL,
	issue_date TIMESTAMP NOT NULL,
	return_date TIMESTAMP NOT NULL,
	reader_id int NOT NULL,
	CONSTRAINT issues_pk PRIMARY KEY (issue_id)
) WITH (OIDS=FALSE);


-- Инструкции для таблицы issuebook
COMMENT ON TABLE issuebook IS 'Связь между книгами и выдачами';
COMMENT ON COLUMN issuebook.id IS 'ID связи';
COMMENT ON COLUMN issuebook.book_id IS 'ID книги';
COMMENT ON COLUMN issuebook.issue_id IS 'ID выдачи';
-- Создание таблицы issuebook

CREATE TABLE IF NOT EXISTS issuebook (
	id serial NOT NULL,
	book_id int NOT NULL,
	issue_id int NOT NULL,
	CONSTRAINT issuebook_pk PRIMARY KEY (id)
) WITH (OIDS=FALSE);


-- Инструкции для таблицы authors
COMMENT ON TABLE authors IS 'Авторы';
COMMENT ON COLUMN authors.author_id IS 'ID автора';
COMMENT ON COLUMN authors.authot_name IS 'Имя автора';
-- Создание таблицы authors

CREATE TABLE IF NOT EXISTS authors (
	author_id serial NOT NULL,
	authot_name TEXT NOT NULL,
	CONSTRAINT authors_pk PRIMARY KEY (author_id)
) WITH (OIDS=FALSE);

-- Связи таблиц
ALTER TABLE books 
	  ADD CONSTRAINT books_fk_author_id FOREIGN KEY (first_author_id) 
	  REFERENCES authors(author_id);
ALTER TABLE books 
	  ADD CONSTRAINT books_fk_publisher_id FOREIGN KEY (publisher_id) 
	  REFERENCES publishers(publisher_id);


ALTER TABLE issues 
	  ADD CONSTRAINT issues_fk_reader_id FOREIGN KEY (reader_id) REFERENCES readers(reader_id);

ALTER TABLE issuebook 
	  ADD CONSTRAINT issuebook_fk_book_id FOREIGN KEY (book_id) 
	  REFERENCES books(book_id);
ALTER TABLE issuebook 
	  ADD CONSTRAINT issuebook_fk_issue_id FOREIGN KEY (issue_id) 
	  REFERENCES issues(issue_id);


