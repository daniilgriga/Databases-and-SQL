
-- 1.
SELECT
	Good_id,
	Good,
	QtyInStock,
	Volume,
    (QtyInStock * Volume) as total_volume
FROM
	Goods
WHERE (QtyInStock * Volume) > :param;

-- 2.
SELECT
	City,
	COUNT(*) as customer_count
FROM
	Customers
GROUP BY City
HAVING COUNT(*) < 5;

-- 3.
SELECT
	d.Data,
	d.DocNum,
	g.Good,
	dd.Qty,
	dd.Price
FROM
	Docs d
INNER JOIN Docs_data dd ON d.DocNum = dd.DocNum
INNER JOIN Goods g ON dd.Good_id = g.Good_id
WHERE d.Cust_ID = :param;

-- 4.
SELECT DISTINCT
	g.Good
FROM
	Goods g
INNER JOIN Docs_data dd ON g.Good_id = dd.Good_id
INNER JOIN Docs d ON dd.DocNum = d.DocNum
WHERE
	EXTRACT(YEAR FROM d.Data) = 2025
  AND
	EXTRACT(MONTH FROM d.Data) = 10;

-- 5.
SELECT DISTINCT
	c.City
FROM
	Customers c
INNER JOIN Docs d ON c.Cust_id = d.Cust_ID
INNER JOIN Docs_data dd ON d.DocNum = dd.DocNum
WHERE dd.Good_id = :param;

-- 6.
SELECT
	c.Customer
FROM
	Customers c
INNER JOIN Docs d ON d.Cust_ID = c.Cust_ID
INNER JOIN Docs_data dd ON dd.Docnum = d.Docnum
WHERE
	EXTRACT(YEAR FROM d.Data) = 2025
  AND
	EXTRACT(MONTH FROM d.Data) = 10
ORDER BY dd.Price Desc
LIMIT 1;

-- 7.
SELECT
	SUM (dd.Qty * g.Volume) as volume_sold
FROM
	Docs_data dd
INNER JOIN Goods g ON dd.Good_id = g.Good_id
INNER JOIN Docs d ON dd.DocNum = d.DocNum
WHERE
	EXTRACT(YEAR FROM d.Data) = 2025
  AND
	EXTRACT(MONTH FROM d.Data) = 10;

-- 8.
SELECT
	c.City,
	SUM (d.Total) AS sales
FROM
	Customers c
INNER JOIN Docs d ON d.Cust_ID = c.Cust_ID
GROUP BY c.City
ORDER BY sales DESC;

-- 9.
-- 9.1
SELECT
 	c.Customer,
 	SUM (dd.Qty) as total_qty,
 	SUM (dd.Qty * dd.Price) as total_coost,
 	SUM (dd.Qty * g.Mass) as total_mass,
  	SUM (dd.Qty * g.Volume) as total_volume
FROM
	Customers c
INNER JOIN Docs d ON c.Cust_id = d.Cust_ID
INNER JOIN Docs_data dd ON d.DocNum = dd.DocNum
INNER JOIN Goods g ON dd.Good_id = g.Good_id
GROUP BY c.Customer;

-- 9.2
SELECT
	c.Customer,
 	SUM (dd.Qty) as total_qty,
 	SUM (dd.Qty * dd.Price) as total_cost,
 	SUM (dd.Qty * g.Mass) as total_mass,
  	SUM (dd.Qty * g.Volume) as total_volume
FROM
	Customers c
INNER JOIN Docs d ON c.Cust_id = d.Cust_ID
INNER JOIN Docs_data dd ON d.DocNum = dd.DocNum
INNER JOIN Goods g ON dd.Good_id = g.Good_id
WHERE g.Good ILIKE '%монитор%'
GROUP BY c.Customer;

-- 10.
SELECT
  	d.DocNum,
  	d.Total as header_ttl,
 	SUM (dd.Qty * dd.Price) as calculated_ttl,
  	ABS (d.Total - SUM (dd.Qty * dd.Price)) as diff
FROM
	Docs d
INNER JOIN Docs_data dd ON d.DocNum = dd.DocNum
GROUP BY d.DocNum, d.Total
HAVING ABS (d.Total - SUM (dd.Qty * dd.Price)) > 0.01;
