CREATE TABLE cats
    (
        price FLOAT,
        birthday DATETIME,
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
    );
    
INSERT INTO cats(price,birthday) VALUES (399.99, NOW());

-- formatting dates: 'APRIL 21th 2017'
SELECT CONCAT(MONTHNAME(birthday), ' ', DAY(birthday), 'th ', YEAR(birthday)) AS 'Date & Time' FROM cats;
SELECT DATE_FORMAT(birthday, '%M %dth %y') AS 'Date & Time' FROM cats;

