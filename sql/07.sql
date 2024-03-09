/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE fa.film_id IN (
    SELECT DISTINCT film_id
    FROM film_actor
    WHERE actor_id IN (
        SELECT DISTINCT actor_id
        FROM film_actor
        WHERE film_id IN (
            SELECT DISTINCT film_id
            FROM film_actor
            WHERE actor_id = (
                SELECT actor_id
                FROM actor
                WHERE first_name || ' ' || last_name = 'RUSSELL BACALL'
            )
        ) AND actor_id != (
            SELECT actor_id
            FROM actor
            WHERE first_name || ' ' || last_name = 'RUSSELL BACALL'
        )
    )
) AND a.actor_id NOT IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT DISTINCT film_id
        FROM film_actor
        WHERE actor_id = (
            SELECT actor_id
            FROM actor
            WHERE first_name || ' ' || last_name = 'RUSSELL BACALL'
        )
    )
) AND a.actor_id != (
    SELECT actor_id
    FROM actor
    WHERE first_name || ' ' || last_name = 'RUSSELL BACALL'
)
ORDER BY "Actor Name";
