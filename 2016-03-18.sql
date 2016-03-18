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