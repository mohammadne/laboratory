-- Q: for each serie, find the average corresponding rate

SELECT title, AVG(rating) as avg_rate 
FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rate DESC;

-- +----------------------+----------+
-- | title                | avg_rate |
-- +----------------------+----------+
-- | Halt and Catch Fire  |  9.90000 |
-- | Fargo                |  9.40000 |
-- | Breaking Bad         |  9.36000 |
-- | Stranger Things      |  8.76667 |
-- | Freaks and Geeks     |  8.60000 |
-- | Archer               |  8.12000 |
-- | Curb Your Enthusiasm |  8.12000 |
-- | Arrested Development |  8.08000 |
-- | Bojack Horseman      |  7.94000 |
-- | Seinfeld             |  7.60000 |
-- | Bob's Burgers        |  7.52000 |
-- | General Hospital     |  5.38000 |
-- +----------------------+----------+
