USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimGender]    Script Date: 11/14/2020 9:17:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marlon Louis
-- Create date: 11/14/2020
-- Description:	Loads data into the Gender table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimGender] @UserAuthorizationKey INT
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
    
    INSERT INTO [CH01-01-Dimension].[DimGender] (
        Gender, GenderDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT DISTINCT Gender, CASE Gender WHEN 'M' THEN 'Male' ELSE 'Female' END AS GenderDescription, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
    FROM FileUpload.OriginallyLoadedData 
        

        ---VIEW for NEW Table---
    EXEC('
    DROP VIEW IF EXISTS G10_4.uvw_DimGender')
    EXEC('
    CREATE VIEW G10_4.uvw_DimGender AS
    SELECT Gender, GenderDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimGender] ')
    ---VIEW for NEW Table--


     DECLARE @EndingDateTime DATETIME2;
    set @EndingDateTime = SYSDATETIME()

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimGender);

    EXEC [Process].[usp_TrackWorkFlow]
        'Procedure: [Project2].[Load_DimGender]  loads data into [CH01-01-Dimension].[DimGender]',
        @WorkFlowStepTableRowCount,
        @StartingDateTime,
        @EndingDateTime,
        @UserAuthorizationKey

	EXEC('SELECT * FROM G10_4.uvw_DimGender')
END;
