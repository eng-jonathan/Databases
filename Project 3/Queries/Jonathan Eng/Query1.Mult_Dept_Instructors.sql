/*Q1: Shows Instructors that teach in Multiiple Departments*/
SELECT DISTINCT Multi_Department_Instructors.InstructorFullName, MAX(Multi_Department_Instructors.Quantity) AS Num_Departments
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