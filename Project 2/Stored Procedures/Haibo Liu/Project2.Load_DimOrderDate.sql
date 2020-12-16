USE [BIClass]
GO


/****** Object:  StoredProcedure [Project2].[Load_DimOrderDate]    Script Date: 11/14/2020 12:15:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Haibo Liu
-- Create date: 11/14/2020
-- Description:	[Project2].[Load_DimOrderDate]
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimOrderDate]
	@UserAuthorizationKey INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime DATETIME2;
    SET @StartingDateTime = SYSDATETIME();
	

	insert into [CH01-01-Dimension].[DimOrderDate]
	([OrderDate],[MonthName],MonthNumber,[Year],UserAuthorizationKey,DateAdded,DateOfLastUpdate)

	select DISTINCT A.[OrderDate],A.[MonthName],A.MonthNumber,A.[Year],@UserAuthorizationKey,@DateAdded,@DateOfLastUpdate
	from FileUpload.OriginallyLoadedData as A

---VIEW for NEW Table---
	EXEC('
	DROP VIEW IF EXISTS G10_4.uvw_DimOrderDate')
	EXEC('
	CREATE VIEW G10_4.uvw_DimOrderDate AS
	SELECT OrderDate, MonthName, MonthNumber, UserAuthorizationKey, DateAdded, DateOfLastUpdate
	FROM [CH01-01-Dimension].[DimOrderDate] ')
	---VIEW for NEW Table--


	DECLARE @EndingDateTime DATETIME2;
    set @EndingDateTime = SYSDATETIME()

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimOrderDate);

    EXEC [Process].[usp_TrackWorkFlow]
        'Procedure: [Project2].[Load_DimOrderDate]  loads data into [CH01-01-Dimension].[DimOrderDate]',
        @WorkFlowStepTableRowCount,
        @StartingDateTime,
        @EndingDateTime,
        @UserAuthorizationKey

	SELECT *
	FROM G10_4.uvw_DimOrderDate
END



