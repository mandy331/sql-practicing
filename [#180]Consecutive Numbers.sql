/*180. Consecutive Numbers

Input:
+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+

Output:
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

My opinion:
想法一：
1. 想像有一個pointer會從第一筆開始往下每筆查閱。 而這個pointer要記錄兩個值，一個是現在指到的數字和該數字以重複指到的次數。
2. pointer每往下查詢一筆，就紀錄一次，直到記錄到重複次數為3時停止。

想法2:
+----+-----+------+
| Id | Num |Repeat|
+----+-----+------+
| 1  |  1  |   1  |
| 2  |  1  |   2  |
| 3  |  1  |   3  |
| 4  |  2  |   1  |
| 5  |  1  |   1  |
| 6  |  2  |   1  |
| 7  |  2  |   2  |
+----+-----+------+

Value紀錄現在的值
    IF Value == Last Value, Then Repeat += 1
    Else Repeat = 1

SELECT L1.Num as ConsecutiveNums
FROM 
    Logs L1,
    Logs L2,
    Logs L3
WHERE L1.Id = L2.Id - 1
AND L2.Id = L3.Id - 1
AND L1.Num = L2.Num
AND L2.Num = L3.Num;

*/
WITH Recursive CTE AS (
    SELECT Id, Num, 1 AS Times
    FROM Logs
    
    UNION ALL
    
    SELECT L.Id, L.Num, C.Times + 1
    FROM CTE C
        LEFT JOIN Logs L
        ON C.Id = L.Id - 1
    WHERE C.Num = L.Num
)

SELECT DISTINCT Num as ConsecutiveNums
FROM CTE C
WHERE Times >= 3;

