
-- 1.
SELECT
    COUNT(*) AS all_passengers,
    SUM(Survived) AS survived_passengers,
    ROUND(SUM(Survived)::DECIMAL / COUNT(*), 4) AS proportion_of_survivors
FROM Titanic;

-- 2.
SELECT
    Pclass AS class,
    COUNT(*) AS all_passengers,
    SUM(Survived) AS survived_passengers,
    ROUND(SUM(Survived)::DECIMAL / COUNT(*), 4) AS proportion_of_survivors
FROM
	Titanic
GROUP BY Pclass
ORDER BY Pclass;

-- 3.
SELECT
    Pclass AS class,
    Sex,
    COUNT(*) AS all_passengers,
    SUM(Survived) AS survived_passengers,
    ROUND(SUM(Survived)::DECIMAL / COUNT(*), 4) AS proportion_of_survivors
FROM
	Titanic
GROUP BY Pclass, Sex
ORDER BY Pclass, Sex;

-- 4.
SELECT
    Embarked AS embark_port,
    COUNT(*) AS all_passengers,
    SUM(Survived) AS survived_passengers,
    ROUND(SUM(Survived)::DECIMAL / COUNT(*), 4) AS proportion_of_survivors
FROM
	Titanic
WHERE
	Embarked IS NOT NULL
GROUP BY Embarked
ORDER BY Embarked;

-- 5.
SELECT
    Embarked AS embark_port,
    COUNT(*) AS all_passengers
FROM
	Titanic
WHERE Embarked IS NOT NULL
GROUP BY Embarked
ORDER BY all_passengers DESC
LIMIT 1;

-- 6.
SELECT
    Pclass AS class,
    Sex,
    COUNT(*) AS all_passengers,
    ROUND(AVG(Age)::NUMERIC, 2) AS average_age_all,
    ROUND(AVG(CASE WHEN Survived = 1 THEN Age END)::NUMERIC, 2) AS average_age_survived
FROM
	Titanic
GROUP BY Pclass, Sex
ORDER BY Pclass, Sex;

-- 7.
SELECT
    PassengerId,
    Pclass,
    Name,
    Sex,
    Age,
    Fare,
    Ticket
FROM
	Titanic
ORDER BY Fare DESC
LIMIT 10;
/*
 * стоимость билета указана на человека, так как:
 * - есть семьи с одинаковыми фамилиями и разными ценами
 * - разная стоимость у билетов с одинаковым
 */

-- 8.1.
SELECT
    Ticket,
    COUNT(DISTINCT Fare) AS diff_fares_count,
    COUNT(*) AS all_passengers
FROM
	Titanic
GROUP BY Ticket
HAVING COUNT(DISTINCT Fare) > 1;

-- 8.2.
SELECT
    Ticket,
    COUNT(DISTINCT Embarked) AS diff_ports_count,
    COUNT(*) AS all_passengers
FROM
	Titanic
GROUP BY Ticket
HAVING COUNT(DISTINCT Embarked) > 1;

-- 9.
SELECT
    Ticket,
    Pclass,
    Fare,
    Embarked,
    COUNT(*) AS passengers,
    SUM(Survived) AS survived_passengers,
    ROUND(SUM(Survived)::DECIMAL / COUNT(*), 4) AS proportion_of_survivors
FROM
	Titanic
GROUP BY Ticket, Pclass, Fare, Embarked
ORDER BY passengers DESC, proportion_of_survivors DESC;

-- 10.
SELECT
    Ticket,
    Pclass,
    Fare,
    COUNT(*) AS passengers,
    SUM(Survived) AS survived_passengers
FROM
	Titanic
GROUP BY Ticket, Pclass, Fare
HAVING COUNT(*) > 1 AND SUM(Survived) = COUNT(*)
ORDER BY passengers DESC;

-- 11.
SELECT
    'Elizabeth' AS name,
    COUNT(*) AS all_with_name,
    SUM(Survived) AS survived,
    ROUND(SUM(Survived)::DECIMAL / COUNT(*), 4) AS proportion_of_survivors
FROM
	Titanic
WHERE Name LIKE '%Elizabeth%'
UNION ALL
SELECT
    'Mary' AS name,
    COUNT(*) AS all_with_name,
    SUM(Survived) AS survived,
    ROUND(SUM(Survived)::DECIMAL / COUNT(*), 4) AS proportion_of_survivors
FROM
	Titanic
WHERE Name LIKE '%Mary%';
