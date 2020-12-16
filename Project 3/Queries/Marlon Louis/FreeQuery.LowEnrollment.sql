--Find all courses that have less than half enrollment
SELECT ClassKey,
       CourseKey,
       Section,
       CourseCode,
       CourseName,
       CourseDescription,
       InstructorFullName,
       Day,
       Hours
       RoomLocation,
       NumberEnrolled,
       Limit,
       OverTally,
       ModeOfInstruction
       FROM Course.Class WHERE NumberEnrolled < (Limit/2)
	   ORDER BY NumberEnrolled DESC