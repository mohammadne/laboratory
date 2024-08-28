-- Q: show unreviewed series?

SELECT title, reviews.rating
FROM series
LEFT JOIN reviews ON series.id = reviews.series_id
WHERE rating IS NULL;

-- +-----------------------+
-- | title                 |
-- +-----------------------+
-- | Malcolm In The Middle |
-- | Pushing Daisies       |
-- +-----------------------+
