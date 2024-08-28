CREATE TABLE dogs
    (
        name CHAR(5),
        breed VARCHAR(10),
        price DECIMAL(4, 2),
    );

INSERT INTO dogs(name, breed, price) VALUES ('charoline', 'beagle', 432232.9878);

INSERT INTO dogs(name, breed) VALUES ('coinne', 'corgi');

SELECT * FROM dogs;