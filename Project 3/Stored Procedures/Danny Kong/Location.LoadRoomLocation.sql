SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--=======================
-- Author: Danny Kong
-- Procedure: Project3.Load_RoomLocation
-- Create Date: 12/1/2020
-- Description: Loads data from groupnUploadfile.CoursesSpring2017 into Project3.RoomLocation
--=======================
DROP PROCEDURE IF EXISTS [Location].[Load_RoomLocation];
GO

CREATE PROCEDURE [Location].[Load_RoomLocation]
	@UserAuthorizationKey [Udt].[SurrogateKeyInt]
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
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_RoomLocation AS SELECT DISTINCT COALESCE(NULLIF([Location],'' ''), ''AA TBA'') AS RoomLocation FROM groupnUploadfile.CoursesSpring2017;'
    EXEC (@SQL)

	DECLARE @SQL2 AS NVARCHAR(MAX)
	SET @SQL2='CREATE OR ALTER VIEW G10_4.uvw_BuildingRoomNumber AS
	SELECT SUBSTRING([RoomLocation], 3, 100) AS RoomNumber
	FROM G10_4.uvw_RoomLocation;'
	EXEC (@SQL2)

INSERT INTO [Location].[RoomLocation]
(RoomLocation, UserAuthorizationKey, DateAdded, DateOfLastUpdate)

SELECT CS.RoomNumber, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
FROM G10_4.uvw_BuildingRoomNumber AS CS;


    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Location].[RoomLocation]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Project3].[RoomLocation]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;

SELECT *
FROM [Location].[RoomLocation];

END;

