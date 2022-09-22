-- Lab Predictions logistic regression - preparation

-- In order to optimize our inventory, we would like to know which films will be rented next month and we are asked to create a model to predict it.
USE sakila;

-- Task 1: Create a query or queries to extract the information you think may be relevant for building the prediction model. 
-- It should include some film features and some rental features. Use the data from 2005.
SELECT * from film;
-- interesting: title, rental_rate, length, rating
SELECT * from rental;
-- interesting: rental_date, inventory_id
-- film and rental has to be joined via inventory
SELECT * from inventory;
-- inventory_id, film_id
SELECT * FROM category;
-- interesting: name of category
-- category has to be joined over film_category

SELECT f.title, f.rental_duration, f.rental_rate, f.length, f.rating, c.name AS 'category', r.rental_date
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id;

-- Task 2: Create a query to get the list of films and a boolean indicating if it was rented last month (May 2005). 
-- This would be our target variable.

SELECT f.title, f.rental_rate, f.length, f.rating, f.rental_duration, (
SELECT
CASE WHEN rental_date BETWEEN '2005-05-00 00:00:00' AND '2005-06-00 00:00:00' then 1
else 0
end as rented_may) as rentals_may
from sakila.rental r
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
ORDER BY f.title;

-- build the boolean in python!