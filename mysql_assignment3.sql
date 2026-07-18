

-- 1. List all customers along with the films they have rented.

SELECT * FROM sakila.film;
SELECT * FROM sakila.customer;
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    f.title AS film_title,
    r.rental_date
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
ORDER BY c.last_name, c.first_name, r.rental_date;
-- 2. List all customers and show their rental count, including those who haven't rented any films.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS rental_count
FROM 
    customer c
LEFT JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name
ORDER BY 
    rental_count DESC, 
    c.last_name ASC;
-- 3. Show all films along with their category. Include films that don't have a category assigned.

SELECT * FROM sakila.film;
SELECT 
    f.title AS film_title, 
    c.name AS category_name
FROM 
    film f
LEFT JOIN 
    film_category fc ON f.film_id = fc.film_id
LEFT JOIN 
    category c ON fc.category_id = c.category_id;
    
-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email AS customer_email,
    s.staff_id,
    s.first_name,
    s.last_name,
    s.email AS staff_email
FROM customer c
LEFT JOIN staff s
ON c.email = s.email
UNION
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email AS customer_email,
    s.staff_id,
    s.first_name,
    s.last_name,
    s.email AS staff_email
FROM customer c
RIGHT JOIN staff s
ON c.email = s.email;
    
-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".

DELIMITER //

CREATE PROCEDURE get_actors(IN film_title VARCHAR(255))
BEGIN
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name
    FROM sakila.film_actor fa
    JOIN sakila.actor a
        ON fa.actor_id = a.actor_id
    JOIN sakila.film f
        ON fa.film_id = f.film_id
    WHERE f.title = film_title;
END //

DELIMITER ;

CALL get_actors('ACADEMY DINOSAUR');
-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.
SELECT s.store_id,
COUNT(st.staff_id) AS staff_working
FROM sakila.store s
LEFT JOIN sakila.staff st
ON s.store_id = st.store_id
GROUP BY s.store_id;


-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.

DELIMITER //

CREATE PROCEDURE rentedfilms_morethan(IN num INT)
BEGIN
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS rental_count
    FROM sakila.customer c
    JOIN sakila.rental r
        ON c.customer_id = r.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
    HAVING COUNT(r.rental_id) > num;
END //

DELIMITER ;

CALL rentedfilms_morethan(5);
