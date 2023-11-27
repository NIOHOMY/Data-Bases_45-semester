
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
