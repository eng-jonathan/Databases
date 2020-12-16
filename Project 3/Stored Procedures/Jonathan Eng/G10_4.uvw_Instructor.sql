/*Object:  StoredProcedure [Department].[Instructor]*/

SET ANSI_NULLS ON;

GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:      Jonathan Eng
-- Create date: 12/9/2020
-- Description: <Load Data into Instructor>; [Project3].[Load_Instructor], 
-- =============================================
CREATE OR ALTER PROCEDURE [Project3].[Load_Instructor] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded [Udt].[Dateof];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[Dateof];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[Dateof];
    SET @StartingDateTime = SYSDATETIME();
	/*=============VIEW=================*/
	DECLARE @SQL AS NVARCHAR(MAX)
	DROP VIEW IF EXISTS G10_4.uvw_Instructor
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_Instructor_Temp1 AS
		SELECT DISTINCT 
			CASE WHEN LEN(Instructor)<2 THEN ''TBA''
			ELSE
			COALESCE(
				NULLIF(
					SUBSTRING(Instructor, 1, 
						CASE when CHARINDEX('','', Instructor) = 0 OR CHARINDEX('' '', Instructor) = 0 THEN len(Instructor)
						ELSE	  CHARINDEX('','', Instructor)-1 END)
					,'',''), ''TBA'')					
					END AS InstructorLastName1,
			COALESCE(NULLIF(SUBSTRING(Instructor,    CHARINDEX('' '', Instructor) + 1, LEN(Instructor)) ,'',''), ''TBA'') AS InstructorFirstName1,
			COALESCE(NULLIF(Instructor,'',''), ''TBA'') AS InstructorFullName1,
			COALESCE(NULLIF(SUBSTRING([Course (hr, crd)], 0, CHARINDEX('' '', [Course (hr, crd)])),'' ''), ''TBA'') AS DepartmentName1
		FROM groupnUploadfile.CoursesSpring2017'
    EXEC (@SQL)

	DECLARE @SQL2 AS NVARCHAR(MAX)
    SET @SQL2='CREATE OR ALTER VIEW G10_4.uvw_Instructor_Temp2 AS

		SELECT DISTINCT 
			COALESCE(NULLIF(InstructorLastName1,'' ''), ''TBA'') AS InstructorLastName2,
			COALESCE(NULLIF(InstructorFirstName1,'' ''), ''TBA'') AS InstructorFirstName2,
			COALESCE(NULLIF(InstructorFullName1,'' ''), ''TBA'') AS InstructorFullName2,
			COALESCE(NULLIF(DepartmentName1,'' ''), ''TBA'') AS DepartmentName2
		FROM G10_4.uvw_Instructor_Temp1'
    EXEC (@SQL2)

	DECLARE @SQL3 AS NVARCHAR(MAX)
    SET @SQL3='CREATE OR ALTER VIEW G10_4.uvw_Instructor_Temp3 AS
		SELECT DISTINCT DepartmentName2, ROW_NUMBER() OVER(ORDER BY DepartmentName2) AS DepartmentKey
		FROM G10_4.uvw_Instructor_Temp2
		GROUP BY DepartmentName2'
    EXEC (@SQL3)

	DECLARE @SQL4 AS NVARCHAR(MAX)
	SET @SQL4 = 'CREATE OR ALTER VIEW G10_4.uvw_Instructor AS
		SELECT a.InstructorLastName2 as InstructorLastName, 
			a.InstructorFirstName2 as InstructorFirstName,
			a.InstructorFullName2 as InstructorFullName,
			a.DepartmentName2 as DepartmentName,
			b.DepartmentKey as DepartmentKey
		FROM G10_4.uvw_Instructor_Temp2 as a
		INNER JOIN G10_4.uvw_Instructor_Temp3 as b
		on a.DepartmentName2 = b.DepartmentName2'
	EXEC (@SQL4)

	INSERT INTO Department.Instructor (InstructorFirstName, InstructorLastName, InstructorFullName, DepartmentName, DepartmentKey, UserAuthorizationKey, DateAdded, DateOfLastUpdate) 
	SELECT InstructorFirstName, InstructorLastName, InstructorFullName, DepartmentName, DepartmentKey, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
	FROM G10_4.uvw_Instructor;

    DECLARE @EndingDateTime [Udt].[Dateof];
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [Department].[Instructor]);
	
    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Department].[ModeOfInstruction]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Department].[Instructor];

END;
