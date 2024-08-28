SELECT UPPER ('Hello World');

-- +-----------------------+
-- | UPPER ('Hello World') |
-- +-----------------------+
-- | HELLO WORLD           |
-- +-----------------------+

SELECT LOWER ('Hello World');

SELECT UPPER (title) FROM books;

SELECT CONCAT ('MY FAVORITE BOOK IS ', LOWER (title)) FROM books;

SELECT CONCAT ('MY FAVORITE BOOK IS ', UPPER (title)) AS 'upper favorite' FROM books;

-- +-------------------------------------------------------------------------+
-- | upper favorite                                                          |
-- +-------------------------------------------------------------------------+
-- | MY FAVORITE BOOK IS THE NAMESAKE                                        |
-- | MY FAVORITE BOOK IS NORSE MYTHOLOGY                                     |
-- +-------------------------------------------------------------------------+
