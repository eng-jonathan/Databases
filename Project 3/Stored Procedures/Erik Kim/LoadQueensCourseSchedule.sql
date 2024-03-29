/****** Object:  StoredProcedure [Project3].[LoadData]    Script Date: 12/8/2020 9:05:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/7/2020>
-- Description:	<Load Data>
-- =============================================
CREATE PROCEDURE [Project3].[LoadData] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;
	    DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

    --
    --	Drop All of the foreign keys prior to truncating tables
 	--
    EXEC  [Project3].[DropForeignKeys] @UserAuthorizationKey = 1;
	--
	--	Check row count before truncation
	EXEC	[Project3].[ShowTableStatusRowCount]
		@UserAuthorizationKey = 1,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Pre-truncate of tables'''
    --
    --	Always truncate the data
    --
    EXEC  [Project3].[TruncateData] @UserAuthorizationKey = 1;
    --
    --	Load the schema
    --

	EXEC  [Project3].[Load_ModeOfInstruction] @UserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_Course] @UserAuthorizationKey = 6;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_Class] @UserAuthorizationKey = 5;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_Department] @UserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_Instructor] @UserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_RoomLocation] @UserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
	EXEC  [Project3].[Load_BuildingLocation] @UserAuthorizationKey = 7;  -- Change -1 to the appropriate UserAuthorizationKey
  --
    --	Recreate all of the foreign keys prior after loading
    --
 	--
	--	Check row count before truncation
	EXEC [Project3].[ShowTableStatusRowCount]
		@UserAuthorizationKey = 1,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Row Count after loading'''
	--
   EXEC [Project3].[AddForeignKeys] @UserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    --

	DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = 0;
    DECLARE @EndingDateTime DATETIME2 = SYSDATETIME();
    EXEC [Process].[usp_TrackWorkFlow] 'Load Data',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
END;