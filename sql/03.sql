/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */
SELECT cn.country AS country, SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN country cn ON ct.country_id = cn.country_id
GROUP BY cn.country
ORDER BY total_payments DESC, country;
