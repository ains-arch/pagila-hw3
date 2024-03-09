/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */
-- Count of actors for movies with 'ACADEMY DINOSAUR'
WITH academy_counts AS (
    SELECT
        fa.film_id,
        COUNT(DISTINCT fa.actor_id) AS actor_count
    FROM
        film f
    JOIN
        film_actor fa ON f.film_id = fa.film_id
    WHERE
        fa.actor_id IN (
        SELECT fa.actor_id
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        WHERE f.title IN ('ACADEMY DINOSAUR'))
    GROUP BY
        fa.film_id
),
-- Count of actors for movies with 'AGENT TRUMAN'
agent_counts AS (
    SELECT
        fa.film_id,
        COUNT(DISTINCT fa.actor_id) AS actor_count
    FROM
        film f
    JOIN
        film_actor fa ON f.film_id = fa.film_id
    WHERE
        fa.actor_id IN (
        SELECT fa.actor_id
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        WHERE f.title IN ('AGENT TRUMAN'))
    GROUP BY
        fa.film_id
),
-- Count of actors for movies with 'AMERICAN CIRCUS'
american_counts AS (
    SELECT
        fa.film_id,
        COUNT(DISTINCT fa.actor_id) AS actor_count
    FROM
        film f
    JOIN
       film_actor fa ON f.film_id = fa.film_id
    WHERE
        fa.actor_id IN (
        SELECT fa.actor_id
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        WHERE f.title IN ('AMERICAN CIRCUS'))
    GROUP BY
        fa.film_id
)
SELECT
    f.title
FROM
    film f
LEFT JOIN
    academy_counts ac ON f.film_id = ac.film_id
LEFT JOIN
    agent_counts ag ON f.film_id = ag.film_id
LEFT JOIN
    american_counts am ON f.film_id = am.film_id
GROUP BY
   f.title
HAVING
    COALESCE(SUM(ac.actor_count), 0) + COALESCE(SUM(ag.actor_count), 0) + COALESCE(SUM(am.actor_count), 0) >= 3
ORDER BY
    f.title;
