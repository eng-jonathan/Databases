USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProduct]    Script Date: 11/13/2020 12:15:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jamil Kocacal
-- Create date: 11/14/2020
-- Description:	Populate the product table
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProduct] @UserAuthorizationKey INT
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime DATETIME2;
    SET @StartingDateTime = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimProduct] (
		ProductSubcategoryKey,
		ProductCategory,
		ProductSubcategory,
		ProductCode,
		ProductName,
		Color,
		ModelName,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
		)
	SELECT DISTINCT 
		DPSC.ProductSubcategoryKey,
		OLD.ProductCategory,
		DPSC.ProductSubcategory,
		OLD.ProductCode,
		OLD.ProductName,
		OLD.Color,
		OLD.ModelName,
		@UserAuthorizationKey,
		@DateAdded,
		@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData AS OLD
		FULL JOIN [CH01-01-Dimension].[DimProductSubCategory] AS DPSC
            ON OLD.[ProductSubcategory] = DPSC.[ProductSubcategory];

    ---VIEW for NEW Table---
    EXEC ('
    DROP VIEW IF EXISTS G10_4.uvw_DimProduct');
    EXEC ('
    CREATE VIEW G10_4.uvw_DimProduct AS
    SELECT 
		ProductKey,
		ProductSubcategoryKey,
		ProductCategory,
		ProductSubcategory,
		ProductCode,
		ProductName,
		Color,
		ModelName,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimProduct] ');
    ---VIEW for NEW Table--

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].[DimProduct]);

    EXEC [Process].[usp_TrackWorkFlow] 'Procedure: [Project2].[Load_DimProduct]  loads data into [CH01-01-Dimension].[DimProduct]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;


    SELECT *
    FROM G10_4.uvw_DimProduct;

END;

