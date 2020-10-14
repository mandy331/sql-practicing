/*184. Department Highest Salary

Write a SQL query to find employees who have the highest salary in each of the departments. (must have department)

Input:

Employee
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+

Department
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

Output:
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+

My opinion:
1. 先把Employee和Department合併
2. 如果Employee中的表沒有對應到的Department名稱，代表沒有該部門就不能採計。
3. 把每個部門的最大薪資找出來。
4. 再利用部門名稱和最大薪資去找 Match 的員工。 

*/

WITH T AS (
    SELECT E.Salary, D.Id, D.Name AS Department
    FROM Employee AS E
    LEFT JOIN Department D
    ON E.DepartmentId = D.Id
)

SELECT sub1.Department, E.Name AS Employee, E.Salary
FROM Employee E
RIGHT JOIN 
    (SELECT Id, Department, MAX(Salary) AS max_salary
    FROM T
    WHERE Department IS NOT NULL
    GROUP BY Id) AS sub1
ON E.DepartmentId = sub1.Id AND E.Salary = sub1.max_salary;