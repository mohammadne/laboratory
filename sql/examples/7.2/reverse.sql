SELECT CONCAT ('woof', REVERSE ('woof'));

-- +-----------------------------------+
-- | CONCAT ('woof', REVERSE ('woof')) |
-- +-----------------------------------+
-- | wooffoow                          |
-- +-----------------------------------+

SELECT CONCAT_WS (' - ', author_fname, REVERSE (author_fname)) FROM books;

-- +---------------------------------------------------------+
-- | CONCAT_WS (' - ', author_fname, REVERSE (author_fname)) |
-- +---------------------------------------------------------+
-- | Jhumpa - apmuhJ                                         |
-- | Neil - lieN                                             |
-- +---------------------------------------------------------+
