/*Shows the Amount & Percentage of Professors Teaching in Each Department*/
SELECT DISTINCT DepartmentName, COUNT(InstructorFullName) AS Num_Intstructors, 
CONCAT( CAST(COUNT(InstructorFullName) * 100.00/ 
	(SELECT COUNT(InstructorFullName) FROM Department.Instructor) AS DECIMAL (5,2) ), '%') 
	AS Pct_Of_Instructors

FROM Department.[Instructor]
GROUP BY DepartmentName
ORDER BY Num_Intstructors DESC