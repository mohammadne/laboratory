-- Q: put all data together (double inner join)

SELECT 
    title,
    rating,
    CONCAT(first_name,' ', last_name) AS reviewer
FROM reviewers
INNER JOIN reviews ON reviewers.id = reviews.reviewer_id
INNER JOIN series ON reviews.series_id = series.id
ORDER BY title, rating DESC;

-- +----------------------+--------+-----------------+
-- | title                | rating | reviewer        |
-- +----------------------+--------+-----------------+
-- | Archer               |    8.9 | Colt Steele     |
-- | Archer               |    8.5 | Kimbra Masters  |
-- | Archer               |    8.0 | Thomas Stoneman |
-- | Archer               |    7.7 | Domingo Cortes  |
-- | Archer               |    7.5 | Wyatt Skaggs    |
-- | Arrested Development |    9.9 | Colt Steele     |
-- | Arrested Development |    8.4 | Pinkie Petit    |
-- | Arrested Development |    8.1 | Thomas Stoneman |
-- | Arrested Development |    8.0 | Kimbra Masters  |
-- | Arrested Development |    6.0 | Domingo Cortes  |
-- | Bob's Burgers        |    8.0 | Domingo Cortes  |
-- | Bob's Burgers        |    8.0 | Colt Steele     |
-- | Bob's Burgers        |    7.5 | Pinkie Petit    |
-- | Bob's Burgers        |    7.1 | Kimbra Masters  |
-- | Bob's Burgers        |    7.0 | Thomas Stoneman |
-- | Bojack Horseman      |    8.5 | Colt Steele     |
-- | Bojack Horseman      |    8.3 | Domingo Cortes  |
-- | Bojack Horseman      |    7.8 | Kimbra Masters  |
-- | Bojack Horseman      |    7.6 | Wyatt Skaggs    |
-- | Bojack Horseman      |    7.5 | Thomas Stoneman |
-- | Breaking Bad         |    9.9 | Colt Steele     |
-- | Breaking Bad         |    9.5 | Thomas Stoneman |
-- | Breaking Bad         |    9.3 | Wyatt Skaggs    |
-- | Breaking Bad         |    9.1 | Domingo Cortes  |
-- | Breaking Bad         |    9.0 | Kimbra Masters  |
-- | Curb Your Enthusiasm |    9.1 | Colt Steele     |
-- | Curb Your Enthusiasm |    8.8 | Domingo Cortes  |
-- | Curb Your Enthusiasm |    8.4 | Wyatt Skaggs    |
-- | Curb Your Enthusiasm |    7.8 | Kimbra Masters  |
-- | Curb Your Enthusiasm |    6.5 | Wyatt Skaggs    |
-- | Fargo                |    9.7 | Colt Steele     |
-- | Fargo                |    9.1 | Wyatt Skaggs    |
-- | Freaks and Geeks     |    9.3 | Colt Steele     |
-- | Freaks and Geeks     |    8.8 | Pinkie Petit    |
-- | Freaks and Geeks     |    8.5 | Domingo Cortes  |
-- | Freaks and Geeks     |    7.8 | Wyatt Skaggs    |
-- | General Hospital     |    6.8 | Kimbra Masters  |
-- | General Hospital     |    5.8 | Domingo Cortes  |
-- | General Hospital     |    5.5 | Wyatt Skaggs    |
-- | General Hospital     |    4.5 | Colt Steele     |
-- | General Hospital     |    4.3 | Pinkie Petit    |
-- | Halt and Catch Fire  |    9.9 | Colt Steele     |
-- | Seinfeld             |    8.0 | Kimbra Masters  |
-- | Seinfeld             |    7.2 | Domingo Cortes  |
-- | Stranger Things      |    8.9 | Kimbra Masters  |
-- | Stranger Things      |    8.9 | Domingo Cortes  |
-- | Stranger Things      |    8.5 | Wyatt Skaggs    |
-- +----------------------+--------+-----------------+
