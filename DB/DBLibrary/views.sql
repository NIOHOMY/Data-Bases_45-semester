CREATE OR REPLACE VIEW available_books AS
SELECT *
FROM books
WHERE number_of_examples > 0;

CREATE OR REPLACE VIEW archived_books AS
SELECT *
FROM books
WHERE number_of_examples = 0;

CREATE OR REPLACE VIEW confirmed_issues AS
SELECT 
    issues.issue_id,
    issues.issue_date,
    issues.return_date,
    issues.is_confirmed,
    issues.reader_id,
	issues.price,
    readers.first_name || ' ' || readers.last_name || ' ' || readers.patronymic AS reader_name
    
FROM issues
INNER JOIN readers ON issues.reader_id = readers.reader_id
WHERE is_confirmed = TRUE;

CREATE OR REPLACE VIEW pending_confirmation_issues AS
SELECT 
    issues.issue_id,
    issues.issue_date,
    issues.return_date,
    issues.is_confirmed,
    issues.reader_id,
	issues.price,
    readers.first_name || ' ' || readers.last_name || ' ' || readers.patronymic AS reader_name
    
FROM issues
INNER JOIN readers ON issues.reader_id = readers.reader_id
WHERE is_confirmed = FALSE;

CREATE OR REPLACE VIEW admins AS
SELECT *
FROM user_accounts
WHERE role = 'admin';

CREATE OR REPLACE VIEW managers AS
SELECT *
FROM user_accounts
WHERE role = 'manager';

/*
SELECT * FROM available_books;
SELECT * FROM archived_books;
SELECT * FROM confirmed_issues;
SELECT * FROM pending_confirmation_issues;
SELECT * FROM admins;
SELECT * FROM managers;
*/

