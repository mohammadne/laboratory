-- Q: for each genre, find the average corresponding rate?

SELECT genre, AVG(rating) as avg_rate
FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rate DESC;

-- +-----------+----------+
-- | genre     | avg_rate |
-- +-----------+----------+
-- | Comedy    |  8.16250 |
-- | Drama     |  8.04375 |
-- | Animation |  7.86000 |
-- +-----------+----------+
