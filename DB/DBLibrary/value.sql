UPDATE issues
SET is_confirmed = TRUE
WHERE issue_id = 2;

UPDATE books
SET number_of_examples = 0
WHERE book_id = 1;

UPDATE user_accounts
SET role = 'admin'
WHERE user_id = 1;

UPDATE user_accounts
SET role = 'manager'
WHERE user_id = 2;

UPDATE issuebook
SET returndate = CURRENT_TIMESTAMP
WHERE id = 2;
