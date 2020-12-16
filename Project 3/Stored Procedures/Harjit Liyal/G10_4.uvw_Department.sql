-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Harjit Liyal>
-- Create date: <12/2/2020>
-- Description:	<Load Data Into Department>
-- =============================================
CREATE PROCEDURE [Project3].[Load_Department] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded [Udt].[DateOf];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[DateOf];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[DateOf];
    SET @StartingDateTime = SYSDATETIME();

    DECLARE @SQL AS NVARCHAR(MAX);

    SET @SQL
        = N'CREATE OR ALTER VIEW G10_4.uvw_Department AS SELECT DISTINCT SUBSTRING([Course (hr, crd)], 0, CHARINDEX('' '', [Course (hr, crd)])) AS [DepartmentName]
    FROM groupnUploadfile.CoursesSpring2017;';
    EXEC (@SQL);


    DECLARE @SQL2 AS NVARCHAR(MAX);
    SET @SQL2
        = N'CREATE OR ALTER VIEW G10_4.uvw_Department1 AS SELECT DISTINCT COALESCE(NULLIF([DepartmentName],''''), ''TBA'') AS DepartmentName FROM G10_4.uvw_Department';
    EXEC (@SQL2);

    INSERT INTO Department.Department
    (
        DepartmentName,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DepartmentName,
           @UserAuthorizationKey,
           @DateAdded,
           @DateOfLastUpdate
    FROM G10_4.uvw_Department1;

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Department].[Department]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Department].[Department]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Department].[Department];
END;
