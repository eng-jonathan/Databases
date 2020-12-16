/****** Object:  StoredProcedure [Course].[Load_Course]    Script Date: 12/8/2020 8:53:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Jamil Kocacal
-- Create date: 12/3/2020
-- Description: <Load Data into Course>; [Project3].[Load_Course], 
-- =============================================
CREATE OR ALTER   PROCEDURE [Project3].[Load_Course] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded [Udt].[DateOf];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[DateOf];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[DateOf];
    SET @StartingDateTime = SYSDATETIME();
	/*----- DELETE -----*/
	DECLARE @SQL2 AS NVARCHAR(MAX)
    SET @SQL2=N'
		DROP VIEW IF EXISTS G10_4.uvw_Course
		DROP VIEW IF EXISTS G10_4.uvw_Course1'
    EXEC (@SQL2)
	/*=============VIEW=================*/
	DECLARE @SQL AS NVARCHAR(MAX)
    SET @SQL=N'
		CREATE VIEW G10_4.uvw_Course AS

		SELECT DISTINCT 
			[Course (hr, crd)] as CourseName,
			Description AS Description
	FROM groupnUploadfile.CoursesSpring2017;'
    EXEC (@SQL)
	/*====================================*/
	DECLARE @SQL3 AS NVARCHAR(MAX);
    SET @SQL3
        = N'CREATE OR ALTER VIEW G10_4.uvw_Course1 AS
		   SELECT DISTINCT 
				COALESCE(NULLIF([CourseName],''''), ''TBA'') AS CourseName,
				COALESCE(NULLIF([Description],''''), ''TBA'') AS Description FROM G10_4.uvw_Course';
    EXEC (@SQL3);

	INSERT INTO Course.Course(CourseName, CourseDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
	SELECT  [CourseName], [Description], @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
	FROM G10_4.uvw_Course1;

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [Course].[Course]);
	
    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Project3].[ModeOfInstruction]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Course].[Course];
END;
