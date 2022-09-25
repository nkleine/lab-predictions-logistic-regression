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

-- query: 

SELECT f.title, f.rental_duration, f.rental_rate, f.length, f.rating, c.name AS ‘category’, r.rental_date,
(
SELECT
CASE WHEN r.rental_date BETWEEN '2005-05-00 00:00:00' AND '2005-06-00 00:00:00' then 1
else 0 end as rented_may) as rentals_may FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN film_category f_c ON f_c.film_id = f.film_id
LEFT JOIN category c ON f_c.category_id = c.category_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY f.title;
