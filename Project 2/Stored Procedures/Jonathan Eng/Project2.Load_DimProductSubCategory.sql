USE BIClass;
GO

/****** Object:  StoredProcedure [Project2].[Load_DimProductSubcategory]    
Script Date: 11/14/2020 9:37:05 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		Jonathan Eng
-- Create date: 11/14/2020
-- Description:	[Project2].[Load_DimProductSubcategory]
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductSubcategory] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime DATETIME2;
    SET @StartingDateTime = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimProductSubCategory]
    (
        ProductCategoryKey,
        ProductSubcategory,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
           DPC.ProductCategoryKey,
           OLD.ProductSubcategory,
           @UserAuthorizationKey,
           @DateAdded,
           @DateOfLastUpdate
    FROM FileUpload.OriginallyLoadedData AS OLD
        FULL JOIN [CH01-01-Dimension].[DimProductCategory] AS DPC
            ON OLD.[ProductCategory] = DPC.[ProductCategory];

    ---VIEW for NEW Table---
    EXEC ('
    DROP VIEW IF EXISTS G10_4.uvw_DimProductSubCategory');
    EXEC ('
    CREATE VIEW G10_4.uvw_DimProductSubCategory AS
    SELECT ProductSubCategoryKey, ProductCategoryKey, ProductSubcategory, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimProductSubCategory] ');
    ---VIEW for NEW Table--

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [CH01-01-Dimension].DimProductSubCategory
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Procedure: [Project2].[Load_DimProductSubCategory]  loads data into [CH01-01-Dimension].[DimProductSubCategory]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;

    SELECT *
    FROM G10_4.uvw_DimProductSubCategory;

END;
