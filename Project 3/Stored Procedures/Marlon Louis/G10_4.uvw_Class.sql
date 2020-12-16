/****** Object:  StoredProcedure [Project3].[Load_Class]    Script Date: 12/10/2020 2:18:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marlon Louis
-- Create date: <12/2/2020>
-- Description:	<Load Data Into Class>
-- =============================================
CREATE PROCEDURE [Project3].[Load_Class] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

	TRUNCATE TABLE Course.Class

    DECLARE @DateAdded [Udt].[DateOf];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[DateOf];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[DateOf];
    SET @StartingDateTime = SYSDATETIME();

	--VIEW
	DECLARE @SQL AS NVARCHAR(MAX)
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_Class AS 
		(SELECT c.CourseKey,
		a.Sec,
		a.Code,
		SUBSTRING(a.[Course (hr, crd)], 1, 8) as Course,
		c.CourseDescription,
		CASE WHEN a.Instructor = '','' THEN ''TBA'' ELSE a.Instructor END as Instructor,
		CASE WHEN a.DAY = '' '' THEN ''TBA'' ELSE a.DAY END as Day,
		CASE WHEN a.time = ''-'' THEN ''TBA'' ELSE a.TIME END as Time,
		CASE WHEN a.[Course (hr, crd)] != '' '' THEN SUBSTRING([Course (hr, crd)], CHARINDEX('','', [Course (hr, crd)])+2, (LEN([Course (hr, crd)])-(CHARINDEX('','', [Course (hr, crd)])+2))) END as NumCredits,
		a.Enrolled,
		a.Limit,
		CASE WHEN CAST(a.Enrolled AS INT) > CAST(a.Limit AS INT) then CAST(a.Enrolled AS INT) - CAST(a.Limit AS INT) ELSE 0 END as OverTally,
		mo.ModeOfInstructionKey,
		CASE WHEN a.[Mode of Instruction]	IS NULL THEN ''TBA'' ELSE a.[Mode of Instruction] END as ModeOfInstruction

		FROM groupnUploadfile.CoursesSpring2017 as a inner join [Course].[Course] as c on a.[Course (hr, crd)] = c.CourseName 
		INNER JOIN Course.ModeOfInstruction as mo on a.[Mode of Instruction] = mo.ModeOfInstruction where a.description != '' '');'
		
    EXEC (@SQL)

	INSERT INTO Course.Class
(
	CourseKey,
	Section,
	CourseCode,
	CourseName,
	CourseDescription,
    InstructorFullName,
    Day,
    Hours,
    NumberOfCredits,
    NumberEnrolled,
    Limit,
    OverTally,
	ModeOfInstructionKey,
	ModeOfInstruction,
    UserAuthorizationKey,
	DateAdded,
	DateOfLastUpdate
) 
	SELECT a.CourseKey, a.Sec, a.Code, a.Course, a.CourseDescription, a.instructor, a.day, a.time, a.NumCredits, a.enrolled, a.limit, a.overtally, a.ModeOfInstructionKey, a.ModeOfInstruction, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
	FROM G10_4.uvw_Class AS a;

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Course].[Class]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Project3].[Class]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    
	SELECT * FROM [Course].[Class];
    
END;
