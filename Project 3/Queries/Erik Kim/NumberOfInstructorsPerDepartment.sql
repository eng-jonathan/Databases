SELECT DISTINCT
       DepartmentName,
       COUNT(InstructorFullName) AS NumberOfInstructors
FROM Department.Instructor
GROUP BY DepartmentName;