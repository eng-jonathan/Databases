### [School Database Designing](https://github.com/eng-jonathan/Databases/tree/main/Project%203)
* [Project Specifications](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Project%203%20Specifications.pdf)
* Personal Stored Procedure: [Department.Instructor](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Stored%20Procedures/Jonathan%20Eng/G10_4.uvw_Instructor.sql)
* Personal Queries: [Multi_Department_Insturctors](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Queries/Jonathan%20Eng/Query1.Mult_Dept_Instructors.sql) | [%Instructors_Per_Department](https://github.com/eng-jonathan/Databases/blob/main/Project%203/Queries/Jonathan%20Eng/FreeQuery.Percent_Instructor_PerDept.sql)
* Design and Create a new Databse (*QueensClassScheduleCurrentSemester*) from the single table (*CoursesCurrentSemester*). Create and Document stored procedures to load each of the individual tables based on your databse design.
* Highlight(s)
```
/*Q1: Shows Instructors that teach in Multiiple Departments*/
SELECT DISTINCT Multi_Department_Instructors.InstructorFullName, 
MAX(Multi_Department_Instructors.Quantity) AS Num_Departments
FROM (
	SELECT DISTINCT InstructorFullName, 
	DENSE_RANK() OVER
		(PARTITION BY InstructorFullName ORDER BY DepartmentName) AS Quantity
	FROM Department.[Instructor]
	GROUP BY InstructorFullName,
			 DepartmentName
	HAVING InstructorFullName <> 'TBA') AS Multi_Department_Instructors
GROUP BY Multi_Department_Instructors.InstructorFullName
HAVING MAX(Multi_Department_Instructors.Quantity) > 1
ORDER BY Num_Departments DESC
```
<img src = "Project%203/Images/P03_01.png" width = "250">

```
/*Q2: Shows the Amount & Percentage of Professors Teaching in Each Department*/
SELECT DISTINCT DepartmentName, COUNT(InstructorFullName) AS Num_Intstructors, 
CONCAT( CAST(COUNT(InstructorFullName) * 100.00/ 
	(SELECT COUNT(InstructorFullName) FROM Department.Instructor) AS DECIMAL (5,2) ), '%') 
	AS Pct_Of_Instructors

FROM Department.[Instructor]
GROUP BY DepartmentName
ORDER BY Num_Intstructors DESC
```
<img src = "Project%203/Images/P03_02.png" width = "250">
