/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
WITH recent_rentals AS (
    SELECT
        r.customer_id,
        f.title,
        ROW_NUMBER() OVER (PARTITION BY r.customer_id ORDER BY r.rental_date DESC) AS rn
    FROM
        rental r
    JOIN
        inventory i ON r.inventory_id = i.inventory_id
    JOIN
        film f ON i.film_id = f.film_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    customer c
JOIN
    recent_rentals rr ON c.customer_id = rr.customer_id
WHERE
    rr.rn <= 5
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    SUM(CASE WHEN rr.title IN (
            SELECT DISTINCT f.title
            FROM film f
            JOIN film_category fc ON f.film_id = fc.film_id
            JOIN category cat ON fc.category_id = cat.category_id
            WHERE cat.name = 'Action'
        ) THEN 1 ELSE 0 END) >= 4
ORDER BY
    c.customer_id;
