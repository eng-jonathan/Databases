SELECT CourseName,
       InstructorFullName AS [Instructor Name],
       NumberEnrolled AS [Enrollment Number],
       Limit AS [Enrollment Limit]
FROM Course.[Class]
WHERE CourseName = 'CSCI 331'
ORDER BY NumberEnrolled ASC;

--Harjit Liyal
--Free Query
--Returns the total number of students enrolled for every CSCI 331 with instrutors full name and enrollment limit