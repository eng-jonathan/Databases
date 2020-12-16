SELECT CourseName, COUNT(CourseName) AS NumClasses, SUM(CAST(NumberEnrolled AS INT)) AS TotalEnrollment, SUM(CAST(Limit AS INT)) AS TotalClassLimit, 
CAST(SUM(CAST(NumberEnrolled AS NUMERIC))/SUM(CAST(Limit AS NUMERIC)) * 100 AS NUMERIC) AS EnrollmentPercentage FROM Course.Class WHERE CAST(Limit AS INT) > 0 
GROUP BY courseName


