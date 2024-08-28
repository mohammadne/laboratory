SELECT * FROM series;

SELECT * FROM reviewers;

-- Q: for each serie, find corresponding rate

SELECT title, rating 
FROM series
JOIN reviews ON series.id = reviews.series_id;

-- +----------------------+--------+
-- | title                | rating |
-- +----------------------+--------+
-- | Archer               |    8.0 |
-- | Archer               |    7.5 |
-- | Archer               |    8.5 |
-- | Archer               |    7.7 |
-- | Archer               |    8.9 |
-- | Arrested Development |    8.1 |
-- | Arrested Development |    6.0 |
-- | Arrested Development |    8.0 |
-- | Arrested Development |    8.4 |
-- | Arrested Development |    9.9 |
-- | Bob's Burgers        |    7.0 |
-- | Bob's Burgers        |    7.5 |
-- | Bob's Burgers        |    8.0 |
-- | Bob's Burgers        |    7.1 |
-- | Bob's Burgers        |    8.0 |
-- | Bojack Horseman      |    7.5 |
-- | Bojack Horseman      |    7.8 |
-- | Bojack Horseman      |    8.3 |
-- | Bojack Horseman      |    7.6 |
-- | Bojack Horseman      |    8.5 |
-- | Breaking Bad         |    9.5 |
-- | Breaking Bad         |    9.0 |
-- | Breaking Bad         |    9.1 |
-- | Breaking Bad         |    9.3 |
-- | Breaking Bad         |    9.9 |
-- | Curb Your Enthusiasm |    6.5 |
-- | Curb Your Enthusiasm |    7.8 |
-- | Curb Your Enthusiasm |    8.8 |
-- | Curb Your Enthusiasm |    8.4 |
-- | Curb Your Enthusiasm |    9.1 |
-- | Fargo                |    9.1 |
-- | Fargo                |    9.7 |
-- | Freaks and Geeks     |    8.5 |
-- | Freaks and Geeks     |    7.8 |
-- | Freaks and Geeks     |    8.8 |
-- | Freaks and Geeks     |    9.3 |
-- | General Hospital     |    5.5 |
-- | General Hospital     |    6.8 |
-- | General Hospital     |    5.8 |
-- | General Hospital     |    4.3 |
-- | General Hospital     |    4.5 |
-- | Halt and Catch Fire  |    9.9 |
-- | Seinfeld             |    8.0 |
-- | Seinfeld             |    7.2 |
-- | Stranger Things      |    8.5 |
-- | Stranger Things      |    8.9 |
-- | Stranger Things      |    8.9 |
-- +----------------------+--------+
