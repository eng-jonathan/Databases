SELECT DISTINCT
	[CourseName],
	[InstructorFullName],
	[Hours],
	[Day],
	[NumberEnrolled],
	[Limit]
	FROM Course.Class where [CourseName] LIKE 'CSCI%' AND [NumberEnrolled] < [Limit] 