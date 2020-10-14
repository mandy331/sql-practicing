/*177. Nth Highest Salary

Input:
+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+

Output:
+-------+---------+
| score | Rank    |
+-------+---------+
| 4.00  | 1       |
| 4.00  | 1       |
| 3.85  | 2       |
| 3.65  | 3       |
| 3.65  | 3       |
| 3.50  | 4       |
+-------+---------+

My opinion:
1. 把Scores Table先去重複值後，由大到小新增Rank欄位為sub。
2. sub Table再和Scores Table left join得到Output。
*/

SELECT S.Score, sub.Rank
FROM Scores AS S
LEFT JOIN
    (SELECT 
        DISTINCT Score, 
        DENSE_RANK() OVER(ORDER BY Score DESC) AS 'Rank' 
     FROM Scores) AS sub
ON S.Score = sub.Score
ORDER BY Score DESC;