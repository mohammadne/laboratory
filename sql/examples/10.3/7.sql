-- Q: analyse the reviewers

SELECT 
    CONCAT (first_name, ' ', last_name) AS REVIEWER,
    COUNT(rating) AS COUNT,
    IFNULL(Min(rating), 0) AS MIN, 
    IFNULL(Max(rating), 0) AS MAX, 
    ROUND(IFNULL(AVG(rating), 0), 2) AS AVG,
    CASE
        WHEN IFNULL(AVG(rating), 0) >= 8 THEN 'HIGH' 
        WHEN IFNULL(AVG(rating), 0) > 5 THEN 'MEDIUM'
        ELSE 'LOW' 
    END AS 'AVG QUALITY',
    IF(COUNT(rating) > 0, 'ACTIVE', 'INACTIVE') AS STATUS 
FROM reviewers
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id
ORDER BY COUNT;

-- +-----------------+-------+-----+-----+------+-------------+--------+
-- | REVIEWER        | COUNT | MIN | MAX | AVG  | AVG QUALITY | STATUS |
-- +-----------------+-------+-----+-----+------+-------------+--------+
-- | Marlon Crafford |     2 | 9.1 | 9.7 | 9.40 | HIGH        | ACTIVE |
-- | Thomas Stoneman |     5 | 7.5 | 8.9 | 8.12 | HIGH        | ACTIVE |
-- | Wyatt Skaggs    |     5 | 6.0 | 9.9 | 8.08 | HIGH        | ACTIVE |
-- | Kimbra Masters  |     5 | 7.0 | 8.0 | 7.52 | MEDIUM      | ACTIVE |
-- | Domingo Cortes  |     5 | 7.5 | 8.5 | 7.94 | MEDIUM      | ACTIVE |
-- | Colt Steele     |     5 | 9.0 | 9.9 | 9.36 | HIGH        | ACTIVE |
-- | Pinkie Petit    |     5 | 6.5 | 9.1 | 8.12 | HIGH        | ACTIVE |
-- +-----------------+-------+-----+-----+------+-------------+--------+
