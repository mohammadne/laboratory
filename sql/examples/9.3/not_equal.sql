-- Q: Select all books NOT published in 2017

SELECT title FROM books 
WHERE year != 2017;

-- Q: Select all birthdays between 1990 and 1992

SELECT title FROM cats 
WHERE YEAR(birthdays) >= 1990;

-- Q:Select all items that are in stock AND priced below $19.99

SELECT title FROM books 
WHERE price < 19.99;
