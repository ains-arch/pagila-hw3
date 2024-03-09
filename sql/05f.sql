/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN (
    SELECT category_id
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
) am_categories ON fc.category_id = am_categories.category_id
GROUP BY f.film_id, f.title
HAVING COUNT(DISTINCT fc.category_id) = 2

INTERSECT

SELECT f2.title
FROM film f1
JOIN film_actor fa1 ON (f1.film_id = fa1.film_id)
JOIN actor ON (fa1.actor_id = actor.actor_id)
JOIN film_actor fa2 ON (actor.actor_id = fa2.actor_id)
JOIN film f2 ON (f2.film_id = fa2.film_id)
WHERE f1.title = 'AMERICAN CIRCUS'

UNION
SELECT 'AMERICAN CIRCUS' AS title
ORDER BY title;
