-- Q: books written by Dave Eggers and published after the year 2010 and title of the book contains 'novel' in itself

SELECT * FROM books
WHERE 
    author_fname = 'Eggers' AND 
    released_year > 2000 &&
    title LIKE '%novel%';