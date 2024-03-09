/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
WITH category_top_rented_films AS (
    SELECT
        c.name,
        f.title,
        COUNT(r.rental_id) AS "total rentals",
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC, title DESC) AS rank
    FROM
        category c
    JOIN
        film_category fc ON c.category_id = fc.category_id
    JOIN
        film f ON fc.film_id = f.film_id
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name, f.title, c.category_id
)
SELECT
    name,
    title,
    "total rentals"
FROM
    category_top_rented_films
WHERE
    rank <= 5
ORDER BY
    name, "total rentals" DESC, title;
