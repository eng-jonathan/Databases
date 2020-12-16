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
-- Author:		<Haibo Liu>
-- Create date: <12/3/2020>
-- Description:	<Load Data Into BuildingLocation>
-- =============================================
CREATE PROCEDURE [Project3].[Load_BuildingLocation] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded [Udt].[DateOf];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[DateOf];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[DateOf];
    SET @StartingDateTime = SYSDATETIME();

	DECLARE @SQL AS NVARCHAR(MAX)
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation1
				AS
		SELECT DISTINCT
       ROW_NUMBER() OVER( ORDER BY Sec ) AS id,
       COALESCE(NULLIF([Location], '' ''), ''TBA'') AS Location,
       COALESCE(NULLIF(SUBSTRING([Location], 1, 2), '' ''), ''TBA'') AS BuildingLocation
		FROM groupnUploadfile.CoursesSpring2017;
		
        
		'
	EXEC (@SQL) 
	

	DECLARE @SQL2 AS NVARCHAR(MAX)
	SET @SQL2 = 'CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation2
				AS
				SELECT DISTINCT
				Location,
				BuildingLocation
				FROM G10_4.uvw_BuildingLocation1'
	EXEC (@SQL2) 

	DECLARE @SQL3 AS NVARCHAR(MAX)
	SET @SQL3 ='CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation3
				AS
				SELECT ROW_NUMBER() OVER( ORDER BY Location ) AS id,
				Location,
				BuildingLocation
				FROM G10_4.uvw_BuildingLocation2'
	EXEC (@SQL3) 

	DECLARE @SQL4 AS NVARCHAR(MAX)
	SET @SQL4 = 'CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation4
				AS
				SELECT A.[Location],
				A.BuildingLocation,
				B.RoomLocation,
				B.RoomLocationKey
				FROM G10_4.uvw_BuildingLocation3 AS A FULL OUTER JOIN Location.RoomLocation AS B ON A.id = B.RoomLocationKey '
	EXEC (@SQL4) 

	INSERT INTO [Location].BuildingLocation(BuildingLocation,RoomLocation,RoomLocationKey,UserAuthorizationKey,DateAdded,DateOfLastUpdate)
	SELECT DISTINCT 
        BuildingLocation,RoomLocation,RoomLocationKey,@UserAuthorizationKey,@DateAdded,@DateOfLastUpdate 
		FROM G10_4.uvw_BuildingLocation4 




    DECLARE @EndingDateTime [Udt].[DateOf];
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Location].[BuildingLocation]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Location].[BuildingLocation]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Location].[BuildingLocation];
END;