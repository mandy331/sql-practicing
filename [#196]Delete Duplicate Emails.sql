/*196. Delete Duplicate Emails 
Input:
Person
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.

Output:
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+

Your output is the whole Person table after executing your sql. Use delete statement.

How To Delete Duplicate Rows in MySQL : 
https://www.mysqltutorial.org/mysql-delete-duplicate-rows/
*/

DELETE p1 FROM Person p1
INNER JOIN Person p2
WHERE 
    p1.Id > p2.id AND 
    p1.Email = p2.Email;

