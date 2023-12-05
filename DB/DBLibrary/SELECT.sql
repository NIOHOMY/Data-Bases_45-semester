SELECT b.title_book
FROM issues i
JOIN issuebook ib ON i.issue_id = ib.issue_id
JOIN books b ON ib.book_id = b.book_id
WHERE i.issue_id = 2;


