USE [BIClass]
GO
--DROP VIEW IF EXISTS Loaderr
--GO
--CREATE VIEW Loaderr AS
--SELECT * FROM [CH01-01-Dimension].DimOccupation
--GO
/****** Object:  StoredProcedure [Project2].[Load_DimOccupation]    Script Date: 11/12/2020 3:10:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Haibo Liu
-- Create date: 11/12/2020
-- Description:	[Project2].[Load_DimOccupation]
-- =============================================
DROP PROCEDURE IF EXISTS [Project2].[Load_DimOccupation];
go

create PROCEDURE [Project2].[Load_DimOccupation]
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

	INSERT INTO [CH01-01-Dimension].[DimOccupation]
	(Occupation,UserAuthorizationKey,DateAdded,DateOfLastUpdate)
	SELECT DISTINCT FileUpload.OriginallyLoadedData.[Occupation],@UserAuthorizationKey,@DateAdded,@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData 
		

		---VIEW for NEW Table---
	EXEC('
	DROP VIEW IF EXISTS G10_4.uvw_DimOccupation')
	EXEC('
	CREATE VIEW G10_4.uvw_DimOccupation AS
	SELECT OccupationKey,Occupation,UserAuthorizationKey,DateAdded,DateOfLastUpdate
	FROM [CH01-01-Dimension].[DimOccupation] ')
	---VIEW for NEW Table--
	
	DECLARE @EndingDateTime DATETIME2;
    set @EndingDateTime = SYSDATETIME()

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimOccupation);

    EXEC [Process].[usp_TrackWorkFlow]
        'Procedure: [Project2].[Load_DimOccupation]  loads data into [CH01-01-Dimension].[DimOccupation]',
        @WorkFlowStepTableRowCount,
        @StartingDateTime,
        @EndingDateTime,
        @UserAuthorizationKey

	SELECT *
	FROM G10_4.uvw_DimOccupation
END

