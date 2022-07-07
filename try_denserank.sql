-- try dense rank
SELECT
	product_id,
	product_name,
	list_price,
	DENSE_RANK () OVER ( 
		ORDER BY list_price DESC
	) price_rank 
FROM
	production.products;

-- try partition
SELECT * FROM (
	SELECT
		product_id,
		product_name,
		category_id,
		list_price,
		DENSE_RANK () OVER ( 
			PARTITION BY category_id
			ORDER BY list_price DESC
		) price_rank 
	FROM
		production.products
) t
WHERE price_rank < 3;

