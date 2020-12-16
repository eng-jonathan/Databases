SELECT DISTINCT
       A.CourseName AS [Course Name],
       A.CourseDescription AS [Course Description],
       B.NumberOfCredits AS [Number of Credits],
       C.[ModeOfInstruction] AS [Mode of Instruction]
FROM Course.[Class] AS A
    INNER JOIN Course.[Class] AS B
        ON A.CourseName = B.CourseName
    INNER JOIN Course.[ModeOfInstruction] AS C
        ON C.ModeOfInstruction = 'Online';

--Harjit Liyal
--Free Query
--Returns course name, course description, and number of credits for all online courses.  