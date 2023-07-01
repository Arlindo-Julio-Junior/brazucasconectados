SET @n1 = 7;
SET @n2 = 4;
SELECT (@n1) AS n1, (@n2) AS "n2", (@n1 + @n2) AS "n1 + n2", @n1 * @n2 AS "n1 * n2", (@n1 - @n2) AS "n1 - n2", (@n1 / @n2) AS "n1 / n2", (@n1 % @n2) AS "n1 % n2";