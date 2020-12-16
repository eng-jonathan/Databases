SELECT DISTINCT
	[CourseName],
	[CourseDescription],
	[InstructorFullName],
	[Hours],
	[Day],
	[NumberEnrolled],
	[Limit]
	FROM Course.Class where [CourseName] LIKE '%100%' or [CourseDescription] LIKE 'Intro%' 