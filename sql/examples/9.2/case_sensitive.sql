SELECT title, released_year,
    CASE 
        WHEN released_year >= 2000 
            THEN 'Modern Lit'
            ELSE '20th Century Lit'
    END AS GENRE
FROM books;

-- +-----------------------------------------------------+---------------+------------------+
-- | title                                               | released_year | GENRE            |
-- +-----------------------------------------------------+---------------+------------------+
-- | The Namesake                                        |          2003 | Modern Lit       |
-- | Norse Mythology                                     |          2016 | Modern Lit       |
-- | American Gods                                       |          2001 | Modern Lit       |
-- | Interpreter of Maladies                             |          1996 | 20th Century Lit |
-- | A Hologram for the King: A Novel                    |          2012 | Modern Lit       |
-- | The Circle                                          |          2013 | Modern Lit       |
-- | The Amazing Adventures of Kavalier & Clay           |          2000 | Modern Lit       |
-- | Just Kids                                           |          2010 | Modern Lit       |
-- | A Heartbreaking Work of Staggering Genius           |          2001 | Modern Lit       |
-- | Coraline                                            |          2003 | Modern Lit       |
-- | What We Talk About When We Talk About Love: Stories |          1981 | 20th Century Lit |
-- | Where I'm Calling From: Selected Stories            |          1989 | 20th Century Lit |
-- | White Noise                                         |          1985 | 20th Century Lit |
-- | Cannery Row                                         |          1945 | 20th Century Lit |
-- | Oblivion: Stories                                   |          2004 | Modern Lit       |
-- | Consider the Lobster                                |          2005 | Modern Lit       |
-- +-----------------------------------------------------+---------------+------------------+


SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;
