USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[LoadStarSchemaData]    Script Date: 11/15/2020 7:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName
-- Create date: 
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[LoadStarSchemaData] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;
	    DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

    --
    --	Drop All of the foreign keys prior to truncating tables in the star schema
 	--
    EXEC  [Project2].[DropForeignKeysFromStarSchemaData] @UserAuthorizationKey = 1;
	--
	--	Check row count before truncation
	EXEC	[Project2].[ShowTableStatusRowCount]
		@UserAuthorizationKey = 2,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Pre-truncate of tables'''
    --
    --	Always truncate the Star Schema Data
    --
    EXEC  [Project2].[TruncateStarSchemaData] @UserAuthorizationKey = 1;
    --
    --	Load the star schema
    --
    EXEC  [Project2].[Load_DimProductCategory] @UserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProductSubcategory] @UserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProduct] @UserAuthorizationKey = 6;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_SalesManagers] @UserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimGender] @UserAuthorizationKey = 5;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimMaritalStatus] @UserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimOccupation] @UserAuthorizationKey = 7;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimOrderDate] @UserAuthorizationKey = 7;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimTerritory] @UserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimCustomer] @UserAuthorizationKey = 5;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_Data] @UserAuthorizationKey = 6;  -- Change -1 to the appropriate UserAuthorizationKey
  --
    --	Recreate all of the foreign keys prior after loading the star schema
    --
 	--
	--	Check row count before truncation
	EXEC	[Project2].[ShowTableStatusRowCount]
		@UserAuthorizationKey = 2,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Row Count after loading the star schema'''
	--
   EXEC [Project2].[AddForeignKeysToStarSchemaData] @UserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    --

	DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = 0;
    DECLARE @EndingDateTime DATETIME2 = SYSDATETIME();
    EXEC [Process].[usp_TrackWorkFlow] 'Load Star Schema Data',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
END;
