CREATE TABLE cats
    (
        cat_id INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(100),
        age INT,
        PRIMARY KEY (cat_id)
    );

INSERT INTO cats(name, age) VALUES ('charoline', 17);

INSERT INTO cats(name, age) VALUES ('coinne', 10);

SELECT * FROM cats;