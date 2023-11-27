CREATE OR REPLACE VIEW available_books AS
SELECT *
FROM books
WHERE number_of_examples > 0;

CREATE OR REPLACE VIEW archived_books AS
SELECT *
FROM books
WHERE number_of_examples = 0;

CREATE OR REPLACE VIEW confirmed_issues AS
SELECT *
FROM issues
WHERE is_confirmed = TRUE;

CREATE OR REPLACE VIEW pending_confirmation_issues AS
SELECT *
FROM issues
WHERE is_confirmed = FALSE;

/*
SELECT * FROM available_books;
SELECT * FROM archived_books;
SELECT * FROM confirmed_issues;
SELECT * FROM pending_confirmation_issues;
*/

