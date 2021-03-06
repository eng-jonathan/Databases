USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[DropForeignKeysFromStarSchemaData]    Script Date: 11/15/2020 1:55:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/13/2020
-- Description:	Drop the Foreign Keys from the Star Schema
-- =============================================
ALTER   PROCEDURE [Project2].[DropForeignKeysFromStarSchemaData] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimCustomer;
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimGender;
    ALTER TABLE [CH01-01-Fact].[Data]
    DROP CONSTRAINT FK_Data_DimMaritalStatus;
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimOccupation;
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimOrderDate;
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimProduct;
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimTerritory;
    ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_SalesManagers;
    ALTER TABLE [CH01-01-Dimension].[DimProduct]
    DROP CONSTRAINT FK_DimProduct_DimProductSubCategory;
    ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory]
    DROP CONSTRAINT FK_DimProductSubCategory_DimProductCategory;
    ALTER TABLE [CH01-01-Dimension].DimCustomer
    DROP CONSTRAINT FK_DimCustomer_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimGender
    DROP CONSTRAINT FK_DimGender_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimMaritalStatus
    DROP CONSTRAINT FK_DimMaritalStatus_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimOccupation
    DROP CONSTRAINT FK_DimOccupation_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimOrderDate
    DROP CONSTRAINT FK_DimOrderDate_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimProduct
    DROP CONSTRAINT FK_DimProduct_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimProductCategory
    DROP CONSTRAINT FK_DimProductCategory_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimProductSubCategory
    DROP CONSTRAINT FK_DimProductSubCategory_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].DimTerritory
    DROP CONSTRAINT FK_DimTerritory_UserAuthorization;
    ALTER TABLE [CH01-01-Dimension].SalesManagers
    DROP CONSTRAINT FK_SalesManagers_UserAuthorization;
    ALTER TABLE [CH01-01-Fact].Data DROP CONSTRAINT FK_Data_UserAuthorization;
    ALTER TABLE [Process].[WorkflowSteps]
    DROP CONSTRAINT FK_WorkFlowSteps_UserAuthorization;

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = 0;
    DECLARE @EndingDateTime DATETIME2 = SYSDATETIME();
    EXEC [Process].[usp_TrackWorkFlow] 'Drop Foreign Keys',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
END;