
CREATE OR REPLACE FUNCTION get_user_by_reader_email(email_to_find TEXT)
RETURNS SETOF user_accounts AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM user_accounts
    WHERE email IN (SELECT email FROM readers WHERE email = email_to_find);

    RETURN;
END;
$$ LANGUAGE plpgsql;

/*
SELECT * FROM get_user_by_reader_email('ivanov@e.com');
*/

CREATE OR REPLACE FUNCTION generate_issues(count_issues INT)
RETURNS VOID AS $$
DECLARE
    i INT := 0;
    max_reader_id INT;
BEGIN
    SELECT MAX(reader_id) INTO max_reader_id FROM readers;
    
    WHILE i < count_issues LOOP
        INSERT INTO issues (issue_date, return_date, reader_id)
        VALUES (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '7 days', FLOOR(RANDOM() * max_reader_id) + 1);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


/*
SELECT generate_issues(5);
*/