/*
 * Compute the country with the most customers in it. 
 */
SELECT cn.country
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN country cn ON ct.country_id = cn.country_id
GROUP BY cn.country
ORDER BY COUNT(c.customer_id) DESC
LIMIT 1;
