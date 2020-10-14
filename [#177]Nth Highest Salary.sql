/*177. Nth Highest Salary

Input: Employee 
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

Output:
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

My opinion:
-Sol1
1. 將Employee依照Salary大小排序，由高到低排序
2. 限制顯示筆數為1筆，並且跳過前N-1筆 => 假設顯示第2高Salary，就是跳過(2-1)筆
=> SQL不能寫 LIMIT(N-1),1

-Sol2
1. 跑去StackOverflow，發現有人有跟我一樣的問題，而關鍵差異就再於LIMIT的使用方式，LIMIT不接受數字運算符，所以需要用變數的方式才能看懂。

*/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      IFNULL(
          (SELECT DISTINCT Salary
           FROM Employee
           ORDER BY Salary DESC 
           LIMIT N-1,1) ,NULL)
  );
END

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M = N-1;
  RETURN (
      IFNULL(
          (SELECT DISTINCT Salary
           FROM Employee
           ORDER BY Salary DESC
           LIMIT M,1) ,NULL) -- LIMIT 1 OFFSET M (比較慢，但是效果一樣)
  );
END
