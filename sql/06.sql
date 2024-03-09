/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */
SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) AS "Actor Name"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_actor fa_russell ON f.film_id = fa_russell.film_id
JOIN actor a_russell ON fa_russell.actor_id = a_russell.actor_id
WHERE CONCAT(a_russell.first_name, ' ', a_russell.last_name) = 'RUSSELL BACALL'
AND CONCAT(a.first_name, ' ', a.last_name) != 'RUSSELL BACALL'
ORDER BY "Actor Name";
