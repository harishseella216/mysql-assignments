use sakila;
show tables;
DESCRIBE actor;

-- 1st question  Get all customers whose first name starts with 'J' and who are active.

SELECT * FROM sakila.customer 

SELECT first_name, active
FROM sakila.customer
WHERE first_name LIKE 'J%' 
  AND active = 1;

-- 2 QUESTION Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.

SELECT * FROM sakila.film;

WHERE title LIKE 'ACTION%' 'WAR%'

-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.

SELECT * FROM sakila.actor 
SELECT fist_name , last_name 
WHERE last_name is NOT 'SMITH' AND WHOSE first_name LIKE 'a%'

-- Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.

SELECT  rental_rate, replacement_cost
FROM sakila.film
WHERE rental_rate > 3.0 
AND replacement_cost IS NOT NULL;

-- 5.Count how many customers exist in each store who have active status = 1.

SELECT * FROM sakila.customer
SELECT store_id, COUNT(customer_id) AS active_customer_count
FROM sakila.customer
WHERE active = 1
GROUP BY store_id;

-- 6. Show distinct film ratings available in the film table. from sakila

SELECT DISTINCT rating 
from sakila.film

 --7  Find the number of films for each rental duration where the average length is more than 100 minutes.

SELECT  rental_duration,  
COUNT(film_id) AS number_of_films
FROM sakila.film
GROUP BY rental_duration
HAVING AVG(length) > 100;

-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.

SELECT * FROM sakila.payment;


-- 9. Find customers whose email address is null or ends with '.org'.
SELECT * FROM sakila.customer;
SELECT  customer_id, first_name,  last_name,email 
FROM sakila.customer 
WHERE email IS NULL OR email LIKE '%.org';
    

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.

SELECT rating, rental_rate
FROM sakila.film
WHERE rating IN ('PG', 'G')
ORDER BY rental_rate DESC;
-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
-- 12. List all actors who have appeared in more than 10 films.

SELECT * FROM sakila.actor
-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.

SELECT * FROM sakila.film;

SELECT title, rental_rate, length 
FROM sakila.film 
ORDER BY rental_rate DESC, length DESC 
LIMIT 5;

-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.

-- 15. List the film titles that have never been rented.


