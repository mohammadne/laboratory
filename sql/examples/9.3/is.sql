SELECT name FROM students WHERE name IS NOT NULL;

SELECT * FROM students WHERE name = '' IS TRUE;
-- EQUAL TO
SELECT * FROM students WHERE name = '';

SELECT * FROM students WHERE age = 20 IS FALSE;
-- EQUAL TO
SELECT * FROM students WHERE age != 20;
