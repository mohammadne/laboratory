-- Q: Select all books published after 2000 and not published in even years

-- Answer-1

SELECT title, released_year 
FROM books
WHERE 
    released_year >= 2000 AND
    released_year != 2000 AND
    released_year != 2002 AND
    released_year != 2004 AND
    released_year != 2006 AND
    released_year != 2008 AND
    released_year != 2010 AND
    released_year != 2012 AND
    released_year != 2014 AND
    released_year != 2016;

-- Answer-2

SELECT title, released_year 
FROM books
WHERE
    released_year >= 2000 AND
    released_year NOT IN 
    (2000,2002,2004,2006,2008,2010,2012,2014,2016);
