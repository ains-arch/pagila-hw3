/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT DISTINCT
    f2.title AS title
FROM
    film f1
JOIN
    film_actor fa1 ON f1.film_id = fa1.film_id
JOIN
    actor a1 ON fa1.actor_id = a1.actor_id
JOIN
    film_actor fa2 ON a1.actor_id = fa2.actor_id
JOIN
    film f2 ON fa2.film_id = f2.film_id
JOIN
    actor a2 ON fa2.actor_id = a2.actor_id
JOIN
    film_actor fa3 ON a2.actor_id = fa3.actor_id
JOIN
    film f3 ON fa3.film_id = f3.film_id
WHERE
    f1.title = 'AMERICAN CIRCUS'
GROUP BY
    f2.title
HAVING
    COUNT(DISTINCT a1.actor_id) >= 2
ORDER BY
    title;
