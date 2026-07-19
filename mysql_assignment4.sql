
-- 1. Display all customer details who have made more than 5 payments.
SELECT * 
FROM customer
WHERE customer_id IN
(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) > 5
);

-- 2. Find the names of actors who have acted in more than 10 films.
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS total_films
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;


-- 3.Find the names of customers who never made a payment.
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN
(
    SELECT DISTINCT customer_id
    FROM payment
);

-- 4. List all films whose rental rate is higher than the average rental rate of all films.
SELECT title, rental_rate
FROM film
WHERE rental_rate >
(
    SELECT AVG(rental_rate)
    FROM film
);


-- 5. List the titles of films that were never rented.
SELECT title
FROM film
WHERE film_id NOT IN
(
    SELECT DISTINCT inventory.film_id
    FROM rental
    JOIN inventory
    ON rental.inventory_id = inventory.inventory_id
);



