SELECT 
	COUNT(*),
	f.title

FROM
	rental r, film f, inventory i
WHERE
	r.inventory_id=i.inventory_id
	AND i.film_id=f.film_id
	-- 영화별 매출 순위

GROUP BY f.description
;

-- 내 고민이ㅡ 흔적

-----------------------------------
SELECT
	f.film_id,
	f.title,
	f.rental_rate * COUNT(*) total_rental

FROM
	rental r, 
	film f, 
	inventory i

WHERE
	r.inventory_id=i.inventory_id
	AND i.film_id=f.film_id

GROUP BY 1
;
---------------------------------------
SELECT
	f.title,
	f.rental_rate * COUNT(*) total_rental

FROM
	rental r, 
	film f, 
	inventory i

WHERE
	r.inventory_id=i.inventory_id
	AND i.film_id=f.film_id

GROUP BY 
	f.title
;

-- 이렇게 해도 되는데 f.film_id 가 더 가벼워서 그것으로 그룹을 묶은 것이다. 
----------------------------------------------
DROP TEMPORARY TABLE IF EXISTS revenue_per_film;
CREATE TEMPORARY TABLE revenue_per_film
SELECT
	f.film_id,
	f.title,
	f.rental_rate * COUNT(*) total_rental

FROM
	rental r, 
	film f, 
	inventory i

WHERE
	r.inventory_id=i.inventory_id
	AND i.film_id=f.film_id

GROUP BY 1
;

SELECT
	a.actor_id,
	SUM(rpf.rental_rate)
FROM
	revenue_per_film rpf,
	actor a,
	film_actor fa,
WHERE
	rpf.film_id = fa.film_id
	AND fa.actor_id = a.actor_id
GROUP BY
	1
;

-- 여기까지 내가 생각한 것.
---------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS revenue_per_film;
CREATE TEMPORARY TABLE revenue_per_film
SELECT
	f.film_id,
	f.title,
	f.rental_rate * COUNT(*) total_revenue

FROM
	rental r, 
	film f, 
	inventory i

WHERE
	r.inventory_id=i.inventory_id
	AND i.film_id=f.film_id

GROUP BY 1
;

SELECT
	a.actor_id,
	CONCAT(a.first_name, " ", a.last_name) name,
	SUM(rpf.total_revenue) total_revenue_per_actor
FROM
	revenue_per_film rpf,
	actor a,
	film_actor fa
WHERE
	rpf.film_id = fa.film_id
	AND fa.actor_id = a.actor_id
GROUP BY
	1
ORDER BY
	total_revenue_per_actor DESC
LIMIT 10
;
