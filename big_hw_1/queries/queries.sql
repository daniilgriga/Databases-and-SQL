
-- 2.
SELECT
    P_ID,
    Pow,
    Coefficient
FROM polynomials
WHERE P_ID = $1
ORDER by Pow DESC;

-- 3.
SELECT DISTINCT
  	P_ID
FROM
  	polynomials
WHERE Coefficient = 0;

-- 4.
SELECT
    P_ID,
    Pow,
    Coefficient * $2 AS Coefficient
FROM polynomials
WHERE P_ID = $1;

-- 5.
SELECT
  	CASE
    	WHEN MAX(CASE WHEN Coefficient != 0 THEN Pow END) = $2
    	THEN 'ДА'
    	ELSE 'НЕТ'
  	END AS result
FROM polynomials
WHERE P_ID = $1
GROUP BY P_ID;

-- 6.
SELECT
    Pow,
    SUM(Coefficient) AS Coefficient
FROM polynomials
WHERE P_ID IN ($1, $2)
GROUP BY Pow
HAVING SUM(Coefficient) != 0
ORDER BY Pow DESC;

-- 7.
SELECT
    p1.Pow + p2.Pow AS Pow,
    SUM(p1.Coefficient * p2.Coefficient) AS Coefficient
FROM polynomials p1, polynomials p2
WHERE p1.P_ID = $1 AND p2.P_ID = $2
GROUP BY p1.Pow + p2.Pow
HAVING
    SUM(p1.Coefficient * p2.Coefficient) != 0
ORDER BY
    p1.Pow + p2.Pow DESC;

-- 8.
SELECT SUM(Coefficient * POWER($x, Pow)) AS value
FROM polynomials
WHERE P_ID = $P_ID;

-- 9.
SELECT
    CASE
        WHEN COUNT(*) = 3
            AND SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END) IS NOT NULL
        	AND SUM(CASE WHEN Pow = 2 THEN Coefficient ELSE 0 END) IS NOT NULL
            AND SUM(CASE WHEN Pow = 0 THEN Coefficient ELSE 0 END) IS NOT NULL
            AND POWER(SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END), 2) = 4 *
                	  SUM(CASE WHEN Pow = 2 THEN Coefficient ELSE 0 END) *
                	  SUM(CASE WHEN Pow = 0 THEN Coefficient ELSE 0 END)
        THEN 'ДА'
        ELSE 'НЕТ'
    END AS is_perfect_square
FROM polynomials
WHERE P_ID = $1
GROUP BY P_ID;

-- 10.
SELECT
    COUNT(DISTINCT CASE WHEN p1.Coefficient > 0 THEN p1.Pow END) AS positive_count,
    COUNT(DISTINCT CASE WHEN p1.Coefficient < 0 THEN p1.Pow END) AS negative_count,
    COUNT(DISTINCT CASE WHEN p1.Coefficient = 0 THEN p1.Pow END) AS zero_count
FROM polynomials p1, polynomials p2
WHERE p1.P_ID = $1
  AND p2.P_ID = p1.P_ID
  AND p2.Coefficient != 0
  AND p1.Pow <= p2.Pow;

-- 11.
SELECT
  	CASE
    	WHEN COUNT(*) = COUNT(CASE WHEN Coefficient % 1 = 0 THEN 1 END)
    	THEN 'ДА'
    	ELSE 'НЕТ'
  	END AS all_integers
FROM polynomials
WHERE P_ID = $1;

-- 12.
SELECT
    CASE
        WHEN COUNT(*) = 2
             AND SUM(CASE WHEN Pow = 1 THEN 1 ELSE 0 END) = 1
             AND SUM(CASE WHEN Pow = 0 THEN 1 ELSE 0 END) = 1
             AND MAX(Pow) = 1
             AND SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END) != 0
        THEN CAST(-1 * SUM(CASE WHEN Pow = 0 THEN Coefficient ELSE 0 END) /
                       SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END) AS NUMERIC(10,2))
        ELSE NULL
    END AS root
FROM polynomials
WHERE P_ID = $1;

-- 13.
SELECT
    CASE
        WHEN COUNT(*) = 3
             AND SUM(CASE WHEN Pow = 2 THEN 1 ELSE 0 END) = 1
             AND SUM(CASE WHEN Pow = 1 THEN 1 ELSE 0 END) = 1
             AND SUM(CASE WHEN Pow = 0 THEN 1 ELSE 0 END) = 1
             AND MAX(Pow) = 2
             AND SUM(CASE WHEN Pow = 2 THEN Coefficient ELSE 0 END) != 0
        THEN
            'x1 = ' || CAST(
                      (-1 * SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END) -
                 SQRT(POWER(SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END), 2) -
                        4 * SUM(CASE WHEN Pow = 2 THEN Coefficient ELSE 0 END) *
                            SUM(CASE WHEN Pow = 0 THEN Coefficient ELSE 0 END))
                   ) / (2 * SUM(CASE WHEN Pow = 2 THEN Coefficient ELSE 0 END))
                AS NUMERIC(10,2)
            ) ||
            ', x2 = ' || CAST(
                      (-1 * SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END) +
                 SQRT(POWER(SUM(CASE WHEN Pow = 1 THEN Coefficient ELSE 0 END), 2) -
                        4 * SUM(CASE WHEN Pow = 2 THEN Coefficient ELSE 0 END) *
                            SUM(CASE WHEN Pow = 0 THEN Coefficient ELSE 0 END))
                   ) / (2 * SUM(CASE WHEN Pow = 2 THEN Coefficient ELSE 0 END))
                AS NUMERIC(10,2)
            )
        ELSE 'Не квадратный полином'
    END AS roots
FROM polynomials
WHERE P_ID = $1;

-- 14.
SELECT
    CASE WHEN COUNT(*) = COUNT(CASE WHEN expected_coef = actual_coef THEN 1 END)
         THEN 1 ELSE 0 END as is_multiplied
FROM
(
    SELECT
        p1.Pow + p2.Pow as power,                    			-- складываем степени
        SUM(p1.Coefficient * p2.Coefficient) as expected_coef,  -- перемножаем коэффициенты и суммируем
        p3.Coefficient as actual_coef                			-- коэффициент из 3-го полинома
    FROM polynomials p1, polynomials p2, polynomials p3
    WHERE p1.P_ID = :param1
      AND p2.P_ID = :param2
      AND p3.P_ID = :param3
      AND p1.Pow + p2.Pow = p3.Pow                  			-- равные степени
    GROUP BY p1.Pow + p2.Pow, p3.Coefficient        			-- группируем по результирующей степени
);

-- 15. (хитрим)
SELECT
    CASE WHEN COUNT(*) = COUNT(CASE WHEN expected_coef = actual_coef THEN 1 END)
         THEN 1 ELSE 0 END as is_divided
FROM
(
    SELECT
        p2.Pow + p3.Pow as power,
        SUM(p2.Coefficient * p3.Coefficient) as expected_coef,
        p1.Coefficient as actual_coef
    FROM polynomials p2, polynomials p3, polynomials p1
    WHERE p2.P_ID = :param2
      AND p3.P_ID = :param3
      AND p1.P_ID = :param1
      AND p2.Pow + p3.Pow = p1.Pow
    GROUP BY p2.Pow + p3.Pow, p1.Coefficient
);
