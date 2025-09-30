
-- 2.
SELECT
	DISTINCT CAST("Дата" AS DATE) AS "Дата"
FROM
	public.shw1_table
ORDER BY
	"Дата";

-- 3.
SELECT
	DISTINCT "Покупатель"
FROM
	public.shw1_table
ORDER BY
	"Покупатель";

-- 4.
SELECT
	DISTINCT "Товар"
FROM
	public.shw1_table
WHERE
	"Цена" > 100
ORDER BY
	"Товар";

-- 5.
SELECT
	DISTINCT "Покупатель"
FROM
	public.shw1_table
WHERE
	"Дата" >= CURRENT_DATE - INTERVAL '7 days'
AND
	"Дата" <= CURRENT_DATE;

-- 6.
SELECT
	"Ндок",
	"Дата",
	"Покупатель",
	"Товар",
	"Колво",
	"Цена",
	"Колво" * "Цена" AS "Стоимость"
FROM
	public.shw1_table;

-- 7.
SELECT
    "Ндок",
    "Дата",
    "Покупатель",
    "Товар",
    "Колво",
    "Цена"
FROM
	public.shw1_table
WHERE
(
    EXTRACT (YEAR FROM "Дата") = EXTRACT (YEAR FROM CURRENT_DATE)
    AND EXTRACT (MONTH FROM "Дата") = 1
)
AND
(
    "Покупатель" LIKE 'А%'
    OR ("Колво" > 5 AND "Цена" < 10)
)
ORDER BY
    "Дата" ASC,
    "Цена" DESC;

-- 8.
SELECT
	DISTINCT "Покупатель"
FROM
	public.shw1_table
WHERE
	EXTRACT (YEAR FROM "Дата") = EXTRACT (YEAR FROM CURRENT_DATE) - 1
AND
	EXTRACT (MONTH FROM "Дата") = 9
ORDER BY
	"Покупатель"
LIMIT 5;

-- 9.
SELECT
	DISTINCT "Покупатель"
FROM
	public.shw1_table
WHERE
	"Товар" = :param; -- answer needs ' '

-- 10.
SELECT
	"Ндок"
FROM
	public.shw1_table
ORDER BY
	("Колво" * "Цена") DESC
LIMIT 1;

-- 11. (using the SQL constructor)
SELECT
    "Ндок",
    SUM ("Колво" * "Цена") AS "Итого"
FROM
	public.shw1_table
GROUP BY "Ндок"
ORDER BY "Ндок";
