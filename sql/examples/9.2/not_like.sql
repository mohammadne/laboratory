-- Q: Select books with titles that don't start with 'W'

SELECT title FROM books
WHERE title NOT LIKE 'W%';
