/*
185. Department Top Three Salaries
Input:
Employee
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+

Department
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

Output: find employees who earn the top three salaries in each of the department.
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+

My opinion:

1. E 和 D 依據部門合併
T
+----+-------+--------+--------------+----------------+
| Id | Name  | Salary | DepartmentId | DepartmentName |
+----+-------+--------+--------------+----------------+
| 1  | Joe   | 85000  | 1            |      IT        |
| 2  | Henry | 80000  | 2            |      Sales     |
| 3  | Sam   | 60000  | 2            |      Sales     |
| 4  | Max   | 90000  | 1            |      IT        |
| 5  | Janet | 69000  | 1            |      IT        |
| 6  | Randy | 85000  | 1            |      IT        |
| 7  | Will  | 70000  | 1            |      IT        |
+----+-------+--------+--------------+----------------+

2. 找出每個部門的三個前三高薪水
1 : 90000, 85000, 70000
2 : 80000, 60000
T1
+--------+--------------+----------------+
| Salary | DepartmentId |      Rank      |
+--------+--------------+----------------+
| 90000  | 1            |      1         |
| 85000  | 1            |      2         |
| 70000  | 1            |      3         |
| 69000  | 1            |      4         |
| 80000  | 2            |      1         |
| 60000  | 2            |      2         |
+--------+--------------+----------------+

3. 當部門等於1的時候，如果薪水有這個數字就列出，以此類推。

*/

WITH T AS (
    SELECT E.Salary, D.Id, D.Name AS Department
    FROM Employee AS E
    LEFT JOIN Department D
    ON E.DepartmentId = D.Id
), T1 AS (
    SELECT DISTINCT Id, Department, Salary, DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS 'Rank'
    FROM T
    WHERE Department IS NOT NULL
    ORDER BY Id, Salary DESC
)

SELECT T3.Department, E.Name AS Employee, E.Salary 
FROM Employee E
RIGHT JOIN 
    (SELECT *
    FROM T1
    WHERE T1.Rank <= 3) AS T3
ON E.DepartmentId = T3.Id AND E.Salary = T3.Salary;

WITH T1 AS (
    SELECT DISTINCT DepartmentId, Salary, DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS 'Rank'
    FROM Employee
    WHERE DepartmentId IN (SELECT Id FROM Department)
    ORDER BY DepartmentId, Salary DESC
)

SELECT D.Name AS Department, E.Name AS Employee, E.Salary 
FROM Employee E
RIGHT JOIN 
    (SELECT *
    FROM T1
    WHERE T1.Rank <= 3) AS T3
    ON E.DepartmentId = T3.DepartmentId AND E.Salary = T3.Salary
LEFT JOIN Department D 
    ON D.Id = T3.DepartmentId;

SELECT D.Name AS Department, T.Name AS Employee, T.Salary 
FROM (
     SELECT Name, DepartmentId, Salary, DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS 'Rank'
    FROM Employee E
) AS T
RIGHT JOIN Department D 
    ON D.Id = T.DepartmentId
WHERE T.Rank <= 3;
