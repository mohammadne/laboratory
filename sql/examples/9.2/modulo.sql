-- Q: Select all books published after 2000 and not published in even years

SELECT title, released_year 
FROM books
WHERE
    released_year >= 2000 AND
    released_year % 2 != 0;