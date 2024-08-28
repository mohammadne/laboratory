-- Q: books written by Dave Eggers or published after the year 2010

SELECT * FROM books
WHERE 
    author_fname = 'Eggers' || 
    released_year > 2000;