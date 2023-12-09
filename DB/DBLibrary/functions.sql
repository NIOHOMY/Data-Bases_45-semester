
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

CREATE OR REPLACE FUNCTION generate_issues(num_issues INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    reader_id_val INT;
    book_id_val INT;
    issue_id_val INT;
    num_books INT;
    selected_books INT[];
BEGIN
    
    
    WHILE i <= num_issues LOOP
        
        SELECT reader_id FROM readers order by random() limit 1 INTO reader_id_val; 
        INSERT INTO issues (issue_date, return_date, reader_id) 
        VALUES (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '7 days', reader_id_val)
        RETURNING issue_id INTO issue_id_val;
        
        SELECT CEIL(RANDOM() * 4) INTO num_books;
        
        selected_books := '{}';
        
        FOR j IN 1..num_books LOOP
            LOOP
                
                SELECT book_id FROM books 
                WHERE number_of_examples > 0 AND book_id NOT IN (SELECT unnest(selected_books)) 
                ORDER BY RANDOM() LIMIT 1 INTO book_id_val;
                
                
                IF book_id_val IS NULL THEN
                    EXIT;
                END IF;
                
                selected_books := selected_books || book_id_val;
                
                INSERT INTO issuebook (book_id, issue_id) 
                VALUES (book_id_val, issue_id_val);
                
                EXIT;
            END LOOP;
        END LOOP;
        
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



/*
SELECT generate_issues(5);
*/
