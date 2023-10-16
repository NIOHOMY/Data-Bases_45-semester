/*
-

"public.Publishers" -> Publishers
" -> 
integer -> int
DATE -> TIMESTAMP
DECIMAL -> NUMERIC(10,2) 2 дробная, 10 ширина числа

Books_fk0 -> Books_fk_Reader_ID
+

COMMENT ON TABLE Publishers IS 'Издательства';
COMMENT ON TABLE Publishers.ID IS 'Издательства';
//для каждого поля

CREATE TABLE "public.Publishers" -> CREATE TABLE IF NOT EXISTS Publishers	||	DROP TABLE IF EXISTS Publishers	(удалять с тех у кого нет ссылок)
//для каждой

*/

CREATE TABLE "public.publishers" (
	"publisher_id" serial NOT NULL,
	"name_of_publisher" TEXT NOT NULL,
	"city" TEXT NOT NULL,
	CONSTRAINT "publishers_pk" PRIMARY KEY ("publisher_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.books" (
	"book_id" serial NOT NULL,
	"title_book" TEXT NOT NULL,
	"first_author_id" int NOT NULL,
	"year_of_publication" int NOT NULL,
	"price_books" numeric NOT NULL,
	"number_of_examples" int NOT NULL,
	"publisher_id" int NOT NULL,
	CONSTRAINT "books_pk" PRIMARY KEY ("book_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.readers" (
	"reader_id" serial NOT NULL,
	"reader_full_name" TEXT NOT NULL,
	"address" TEXT NOT NULL,
	"phone_number" TEXT NOT NULL,
	CONSTRAINT "readers_pk" PRIMARY KEY ("reader_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.issues" (
	"issue_id" serial NOT NULL,
	"issue_date" TIMESTAMP NOT NULL,
	"return_date" TIMESTAMP NOT NULL,
	"reader_id" int NOT NULL,
	CONSTRAINT "issues_pk" PRIMARY KEY ("issue_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.issuebook" (
	"id" serial NOT NULL,
	"book_id" int NOT NULL,
	"issue_id" int NOT NULL,
	CONSTRAINT "issuebook_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.authors" (
	"author_id" serial NOT NULL,
	"authot_name" TEXT NOT NULL,
	CONSTRAINT "authors_pk" PRIMARY KEY ("author_id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "books" 
	  ADD CONSTRAINT "books_fk0" FOREIGN KEY ("first_author_id") 
	  REFERENCES "authors"("author_id");
ALTER TABLE "books" 
	  ADD CONSTRAINT "books_fk1" FOREIGN KEY ("publisher_id") 
	  REFERENCES "publishers"("publisher_id");


ALTER TABLE "issues" 
	  ADD CONSTRAINT "issues_fk0" FOREIGN KEY ("reader_id") REFERENCES "readers"("reader_id");

ALTER TABLE "issuebook" 
	  ADD CONSTRAINT "issuebook_fk0" FOREIGN KEY ("book_id") 
	  REFERENCES "books"("book_id");
ALTER TABLE "issuebook" 
	  ADD CONSTRAINT "issuebook_fk1" FOREIGN KEY ("issue_id") 
	  REFERENCES "issues"("issue_id");








