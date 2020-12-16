/****** Object:  User [rheller]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE USER [rheller] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [EC3\thehitman]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE USER [EC3\thehitman] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [EC3\RedgateBackup]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE USER [EC3\RedgateBackup] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [rheller]
GO
ALTER ROLE [db_owner] ADD MEMBER [EC3\thehitman]
GO
ALTER ROLE [db_owner] ADD MEMBER [EC3\RedgateBackup]
GO
/****** Object:  Schema [CH01-01-Dimension]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [CH01-01-Dimension]
GO
/****** Object:  Schema [CH01-01-Fact]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [CH01-01-Fact]
GO
/****** Object:  Schema [DbSecurity]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [DbSecurity]
GO
/****** Object:  Schema [FileUpload]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [FileUpload]
GO
/****** Object:  Schema [G10_4]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [G10_4]
GO
/****** Object:  Schema [PkSequence]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [PkSequence]
GO
/****** Object:  Schema [Process]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [Process]
GO
/****** Object:  Schema [Project2]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [Project2]
GO
/****** Object:  Schema [Utils]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SCHEMA [Utils]
GO
/****** Object:  Sequence [PkSequence].[DataSequenceObject]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SEQUENCE [PkSequence].[DataSequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[DimCustomerSequenceObject]    Script Date: 11/18/2020 6:48:33 PM ******/
CREATE SEQUENCE [PkSequence].[DimCustomerSequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[DimProductCategorySequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[DimProductCategorySequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[DimProductSequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[DimProductSequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[DimProductSubCategorySequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[DimProductSubCategorySequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[DimTerritorySequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[DimTerritorySequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[OccupationSequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[OccupationSequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[SalesManagersSequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[SalesManagersSequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[UserAuthorizationSequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[UserAuthorizationSequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Sequence [PkSequence].[WorkFlowStepsSequenceObject]    Script Date: 11/18/2020 6:48:34 PM ******/
CREATE SEQUENCE [PkSequence].[WorkFlowStepsSequenceObject] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  UserDefinedFunction [Utils].[CalculateDataTypeByteStorage]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Heller
-- Create date: 
-- Description:	
-- =============================================
create FUNCTION [Utils].[CalculateDataTypeByteStorage] 
(
	-- Add the parameters for the function here
	@DataType varchar(50)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Return the result of the function
	RETURN  CASE
                          WHEN CHARINDEX('(', @DataType, 0) > 0
                               AND SUBSTRING(@DataType, 1, 3) = 'var' THEN
                              CAST(SUBSTRING(
                                                @DataType
                                              , CHARINDEX('(', @DataType, 0) + 1
                                              , LEN(@DataType) - CHARINDEX('(', @DataType, 0) - 1
                                            ) AS INT) + 2
                          WHEN CHARINDEX('(', @DataType, 0) > 0
                               AND SUBSTRING(@DataType, 1, 3) = 'cha' THEN
                              CAST(SUBSTRING(
                                                @DataType
                                              , CHARINDEX('(', @DataType, 0) + 1
                                              , LEN(@DataType) - CHARINDEX('(', @DataType, 0) - 1
                                            ) AS INT)
                          WHEN SUBSTRING(@DataType, 1, 3) = 'int' THEN
                              4
                          WHEN SUBSTRING(@DataType, 1, 3) = 'mon' THEN
                              4
                          WHEN SUBSTRING(@DataType, 1, 3) = 'dat' THEN
                              3
                          ELSE
                              -999
                      END

END
GO
/****** Object:  Table [CH01-01-Dimension].[DimProductCategory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimProductCategory](
	[ProductCategoryKey] [int] NOT NULL,
	[ProductCategory] [varchar](20) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductCategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimProductCategory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [G10_4].[uvw_DimProductCategory] AS
	SELECT ProductCategoryKey, ProductCategory, UserAuthorizationKey, DateAdded, DateOfLastUpdate
	FROM [CH01-01-Dimension].[DimProductCategory] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimProductSubCategory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimProductSubCategory](
	[ProductSubcategoryKey] [int] NOT NULL,
	[ProductCategoryKey] [int] NOT NULL,
	[ProductSubcategory] [varchar](20) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductSubcategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimProductSubCategory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_DimProductSubCategory] AS
    SELECT ProductSubCategoryKey, ProductCategoryKey, ProductSubcategory, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimProductSubCategory] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimProduct]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimProduct](
	[ProductKey] [int] NOT NULL,
	[ProductSubcategoryKey] [int] NULL,
	[ProductCategory] [varchar](20) NULL,
	[ProductSubcategory] [varchar](20) NULL,
	[ProductCode] [varchar](10) NULL,
	[ProductName] [varchar](40) NULL,
	[Color] [varchar](10) NULL,
	[ModelName] [varchar](30) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimProduct]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_DimProduct] AS
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
    FROM [CH01-01-Dimension].[DimProduct] 
GO
/****** Object:  Table [CH01-01-Dimension].[SalesManagers]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[SalesManagers](
	[SalesManagerKey] [int] NOT NULL,
	[Category] [varchar](20) NULL,
	[SalesManager] [varchar](50) NULL,
	[Office] [varchar](50) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesManagerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_SalesManagers]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_SalesManagers] AS
    SELECT SalesManagerKey, SalesManager, Category, Office, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[SalesManagers] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimGender]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimGender](
	[Gender] [char](1) NOT NULL,
	[GenderDescription] [varchar](6) NOT NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[Gender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimGender]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_DimGender] AS
    SELECT Gender, GenderDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimGender] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimMaritalStatus]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimMaritalStatus](
	[MaritalStatus] [char](1) NOT NULL,
	[MaritalStatusDescription] [varchar](7) NOT NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaritalStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimMaritalStatus]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_DimMaritalStatus] AS
    SELECT MaritalStatus, MaritalStatusDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimMaritalStatus] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimOccupation]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimOccupation](
	[OccupationKey] [int] NOT NULL,
	[Occupation] [varchar](20) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[OccupationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimOccupation]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [G10_4].[uvw_DimOccupation] AS
	SELECT OccupationKey,Occupation,UserAuthorizationKey,DateAdded,DateOfLastUpdate
	FROM [CH01-01-Dimension].[DimOccupation] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimOrderDate]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimOrderDate](
	[OrderDate] [date] NOT NULL,
	[MonthName] [varchar](10) NULL,
	[MonthNumber] [int] NULL,
	[Year] [int] NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimOrderDate]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [G10_4].[uvw_DimOrderDate] AS
	SELECT OrderDate, MonthName, MonthNumber, UserAuthorizationKey, DateAdded, DateOfLastUpdate
	FROM [CH01-01-Dimension].[DimOrderDate] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimTerritory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimTerritory](
	[TerritoryKey] [int] NOT NULL,
	[TerritoryGroup] [varchar](20) NULL,
	[TerritoryCountry] [varchar](20) NULL,
	[TerritoryRegion] [varchar](20) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[TerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimTerritory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_DimTerritory] AS
    SELECT TerritoryKey, TerritoryGroup, TerritoryCountry, TerritoryRegion, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimTerritory] 
GO
/****** Object:  Table [CH01-01-Dimension].[DimCustomer]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Dimension].[DimCustomer](
	[CustomerKey] [int] NOT NULL,
	[CustomerName] [varchar](30) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_DimCustomer]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_DimCustomer] AS
    SELECT CustomerKey, CustomerName, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimCustomer] 
GO
/****** Object:  Table [CH01-01-Fact].[Data]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CH01-01-Fact].[Data](
	[SalesKey] [int] NOT NULL,
	[SalesManagerKey] [int] NULL,
	[OccupationKey] [int] NULL,
	[TerritoryKey] [int] NULL,
	[ProductKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[ProductCategory] [varchar](20) NULL,
	[SalesManager] [varchar](20) NULL,
	[ProductSubcategory] [varchar](20) NULL,
	[ProductCode] [varchar](10) NULL,
	[ProductName] [varchar](40) NULL,
	[Color] [varchar](10) NULL,
	[ModelName] [varchar](30) NULL,
	[OrderQuantity] [int] NULL,
	[UnitPrice] [money] NULL,
	[ProductStandardCost] [money] NULL,
	[SalesAmount] [money] NULL,
	[OrderDate] [date] NULL,
	[MonthName] [varchar](10) NULL,
	[MonthNumber] [int] NULL,
	[Year] [int] NULL,
	[CustomerName] [varchar](30) NULL,
	[MaritalStatus] [char](1) NULL,
	[Gender] [char](1) NULL,
	[Education] [varchar](20) NULL,
	[Occupation] [varchar](20) NULL,
	[TerritoryRegion] [varchar](20) NULL,
	[TerritoryCountry] [varchar](20) NULL,
	[TerritoryGroup] [varchar](20) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NULL,
	[DateOfLastUpdate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_FactData]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE VIEW [G10_4].[uvw_FactData] AS
    SELECT 
		Saleskey,
		SalesManagerKey,
		OccupationKey,
		TerritoryKey,
		ProductKey,
		CustomerKey,
		ProductCategory,
		SalesManager,
		ProductSubcategory,
		ProductCode,
		ProductName,
		Color,
		ModelName,
		OrderQuantity,
		UnitPrice,
		ProductStandardCost,
		SalesAmount,
		OrderDate,
		[MonthName],
		MonthNumber,
		[Year],
		CustomerName,
		MaritalStatus,
		Gender,
		Education,
		Occupation,
		TerritoryRegion,
		TerritoryCountry,
		TerritoryGroup,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
    FROM [CH01-01-Fact].[Data] 
GO
/****** Object:  View [Utils].[uvw_FindColumnDefinitionPlusDefaultAndCheckConstraint]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--create schema Utils;

CREATE VIEW [Utils].[uvw_FindColumnDefinitionPlusDefaultAndCheckConstraint] AS
SELECT  CONCAT(tbl.TABLE_SCHEMA, '.', tbl.TABLE_NAME) AS FullyQualifiedTableName ,
        tbl.TABLE_SCHEMA AS SchemaName ,
        tbl.TABLE_NAME AS TableName ,
        col.COLUMN_NAME AS ColumnName ,
        col.ORDINAL_POSITION AS OrdinalPosition,
        CONCAT(col.DOMAIN_SCHEMA, '.', col.DOMAIN_NAME) AS FullyQualifiedDomainName ,
        col.DOMAIN_NAME AS DomainName ,
        CASE
                      WHEN col.DATA_TYPE = 'char'
             THEN CONCAT('char(', CHARACTER_MAXIMUM_LENGTH, ')')
                     WHEN col.DATA_TYPE = 'nchar'
             THEN CONCAT('nchar(', CHARACTER_MAXIMUM_LENGTH, ')')
                     WHEN col.DATA_TYPE = 'Nvarchar'
             THEN CONCAT('nvarchar(', CHARACTER_MAXIMUM_LENGTH, ')')
                     WHEN col.DATA_TYPE = 'varchar'
             THEN CONCAT('varchar(', CHARACTER_MAXIMUM_LENGTH, ')')
             WHEN col.DATA_TYPE = 'numeric'
             THEN CONCAT('numeric(', NUMERIC_PRECISION, ', ',
                         NUMERIC_SCALE, ')')
             WHEN col.DATA_TYPE = 'decimal'
             THEN CONCAT('decimal(', NUMERIC_PRECISION, ', ',
                         NUMERIC_SCALE, ')')
             ELSE col.DATA_TYPE
        END AS DataType ,
        col.IS_NULLABLE AS IsNullable,
        dcn.DefaultName ,
        col.COLUMN_DEFAULT AS DefaultNameDefinition ,
        cc.CONSTRAINT_NAME AS CheckConstraintRuleName,
        cc.CHECK_CLAUSE  AS CheckConstraintRuleNameDefinition
FROM    ( SELECT    TABLE_CATALOG ,
                    TABLE_SCHEMA ,
                    TABLE_NAME ,
                    TABLE_TYPE
          FROM      INFORMATION_SCHEMA.TABLES
        ) AS tbl
        INNER JOIN ( SELECT TABLE_CATALOG ,
                            TABLE_SCHEMA ,
                            TABLE_NAME ,
                            COLUMN_NAME ,
                            ORDINAL_POSITION ,
                            COLUMN_DEFAULT ,
                            IS_NULLABLE ,
                            DATA_TYPE ,
                            CHARACTER_MAXIMUM_LENGTH ,
                            CHARACTER_OCTET_LENGTH ,
                            NUMERIC_PRECISION ,
                            NUMERIC_PRECISION_RADIX ,
                            NUMERIC_SCALE ,
                            DATETIME_PRECISION ,
                            CHARACTER_SET_CATALOG ,
                            CHARACTER_SET_SCHEMA ,
                            CHARACTER_SET_NAME ,
                            COLLATION_CATALOG ,
                            COLLATION_SCHEMA ,
                            COLLATION_NAME ,
                            DOMAIN_CATALOG ,
                            DOMAIN_SCHEMA ,
                            DOMAIN_NAME
                     FROM   INFORMATION_SCHEMA.COLUMNS
                   ) AS col ON col.TABLE_CATALOG = tbl.TABLE_CATALOG
                               AND col.TABLE_SCHEMA = tbl.TABLE_SCHEMA
                               AND col.TABLE_NAME = tbl.TABLE_NAME
        LEFT OUTER JOIN ( SELECT    t.name AS TableName ,
                                    SCHEMA_NAME(s.schema_id) AS SchemaName ,
                                    ac.name AS ColumnName ,
                                    d.name AS DefaultName
                          FROM      sys.all_columns AS ac
                                    INNER JOIN sys.tables AS t ON ac.object_id = t.object_id
                                    INNER JOIN sys.schemas AS s ON t.schema_id = s.schema_id
                                    INNER JOIN sys.default_constraints AS d ON ac.default_object_id = d.object_id
                        ) AS dcn ON dcn.SchemaName = tbl.TABLE_SCHEMA
                                    AND dcn.TableName = tbl.TABLE_NAME
                                    AND dcn.ColumnName = col.COLUMN_NAME
        LEFT OUTER JOIN ( SELECT    cu.TABLE_CATALOG ,
                                    cu.TABLE_SCHEMA ,
                                    cu.TABLE_NAME ,
                                    cu.COLUMN_NAME ,
                                    c.CONSTRAINT_CATALOG ,
                                    c.CONSTRAINT_SCHEMA ,
                                    c.CONSTRAINT_NAME ,
                                    c.CHECK_CLAUSE
                          FROM      INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
                                    AS cu
                                    INNER JOIN INFORMATION_SCHEMA.CHECK_CONSTRAINTS
                                    AS c ON c.CONSTRAINT_NAME = cu.CONSTRAINT_NAME
                        ) AS cc ON cc.TABLE_SCHEMA = tbl.TABLE_SCHEMA
                                   AND cc.TABLE_NAME = tbl.TABLE_NAME
                                   AND cc.COLUMN_NAME = col.COLUMN_NAME
 
 
GO
/****** Object:  View [Utils].[uvw_FindTablesStorageBytes]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [Utils].[uvw_FindTablesStorageBytes] as 
select FullyQualifiedTableName
     , ColumnName
     , DataType
     , OrdinalPosition
     , StorageBytes = case
                          when charindex('(', DataType, 0) > 0
                               and substring(DataType, 1, 3) = 'var' then
                              cast(substring(
                                                DataType
                                              , charindex('(', DataType, 0) + 1
                                              , len(DataType) - charindex('(', DataType, 0) - 1
                                            ) as int) + 2
                          when charindex('(', DataType, 0) > 0
                               and substring(DataType, 1, 3) = 'cha' then
                              cast(substring(
                                                DataType
                                              , charindex('(', DataType, 0) + 1
                                              , len(DataType) - charindex('(', DataType, 0) - 1
                                            ) as int)
                          when substring(DataType, 1, 3) = 'int' then
                              4
                          when substring(DataType, 1, 3) = 'mon' then
                              4
                          when substring(DataType, 1, 3) = 'dat' then
                              3
                          else
                              -999
                      end
from Utils.uvw_FindColumnDefinitionPlusDefaultAndCheckConstraint
where (SchemaName like 'CH%');
GO
/****** Object:  View [Utils].[ShowServerUserNameAndCurrentDatabase]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [Utils].[ShowServerUserNameAndCurrentDatabase]
as
       select  ServerName= @@SERVERNAME
       ,       YourUserName =  system_user
       ,       CurrentDatabase =  db_name();  
 
GO
/****** Object:  Table [DbSecurity].[UserAuthorization]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DbSecurity].[UserAuthorization](
	[UserAuthorizationKey] [int] NOT NULL,
	[ClassTime] [nchar](5) NOT NULL,
	[IndividualProject] [nvarchar](60) NULL,
	[GroupMemberLastName] [nvarchar](35) NOT NULL,
	[GroupMemberFirstName] [nvarchar](25) NOT NULL,
	[GroupName] [nvarchar](20) NOT NULL,
	[DateAdded] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserAuthorizationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [FileUpload].[OriginallyLoadedData]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FileUpload].[OriginallyLoadedData](
	[SalesKey] [int] NOT NULL,
	[ProductCategory] [varchar](20) NULL,
	[ProductSubcategory] [varchar](20) NULL,
	[SalesManager] [varchar](20) NULL,
	[ProductCode] [varchar](10) NULL,
	[ProductName] [varchar](40) NULL,
	[Color] [varchar](10) NULL,
	[ModelName] [varchar](30) NULL,
	[OrderQuantity] [int] NULL,
	[UnitPrice] [money] NULL,
	[ProductStandardCost] [money] NULL,
	[SalesAmount] [money] NULL,
	[OrderDate] [date] NULL,
	[MonthName] [varchar](10) NULL,
	[MonthNumber] [int] NULL,
	[Year] [int] NULL,
	[CustomerName] [varchar](30) NULL,
	[MaritalStatus] [char](1) NULL,
	[Gender] [char](1) NULL,
	[Education] [varchar](20) NULL,
	[Occupation] [varchar](20) NULL,
	[TerritoryRegion] [varchar](20) NULL,
	[TerritoryCountry] [varchar](20) NULL,
	[TerritoryGroup] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FileUpload].[ProductCategories]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FileUpload].[ProductCategories](
	[ProductCategory] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FileUpload].[ProductSubcategories]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FileUpload].[ProductSubcategories](
	[ProductSubcategory] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Process].[WorkflowSteps]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[WorkflowSteps](
	[WorkFlowStepKey] [int] NOT NULL,
	[WorkFlowStepDescription] [nvarchar](100) NOT NULL,
	[WorkFlowStepTableRowCount] [int] NULL,
	[StartingDateTime] [datetime2](7) NULL,
	[EndingDateTime] [datetime2](7) NULL,
	[Class Time] [char](5) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkFlowStepKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [CH01-01-Dimension].[DimCustomer] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[DimCustomerSequenceObject]) FOR [CustomerKey]
GO
ALTER TABLE [CH01-01-Dimension].[DimCustomer] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimCustomer] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimGender] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimGender] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimOccupation] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[OccupationSequenceObject]) FOR [OccupationKey]
GO
ALTER TABLE [CH01-01-Dimension].[DimOccupation] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimOccupation] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimOrderDate] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimOrderDate] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[DimProductSequenceObject]) FOR [ProductKey]
GO
ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductCategory] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[DimProductCategorySequenceObject]) FOR [ProductCategoryKey]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductCategory] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductCategory] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[DimProductSubCategorySequenceObject]) FOR [ProductSubcategoryKey]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[DimTerritorySequenceObject]) FOR [TerritoryKey]
GO
ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Dimension].[SalesManagers] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[SalesManagersSequenceObject]) FOR [SalesManagerKey]
GO
ALTER TABLE [CH01-01-Dimension].[SalesManagers] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Dimension].[SalesManagers] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [CH01-01-Fact].[Data] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[DataSequenceObject]) FOR [SalesKey]
GO
ALTER TABLE [CH01-01-Fact].[Data] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [CH01-01-Fact].[Data] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[UserAuthorizationSequenceObject]) FOR [UserAuthorizationKey]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('10:45') FOR [ClassTime]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA') FOR [IndividualProject]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('GROUP 4') FOR [GroupName]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT (NEXT VALUE FOR [PkSequence].[WorkFlowStepsSequenceObject]) FOR [WorkFlowStepKey]
GO
ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT ((0)) FOR [WorkFlowStepTableRowCount]
GO
ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT (sysdatetime()) FOR [StartingDateTime]
GO
ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT (sysdatetime()) FOR [EndingDateTime]
GO
ALTER TABLE [Process].[WorkflowSteps] ADD  DEFAULT ('10:45') FOR [Class Time]
GO
ALTER TABLE [CH01-01-Dimension].[DimCustomer]  WITH CHECK ADD  CONSTRAINT [FK_DimCustomer_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimCustomer] CHECK CONSTRAINT [FK_DimCustomer_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimGender]  WITH CHECK ADD  CONSTRAINT [FK_DimGender_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimGender] CHECK CONSTRAINT [FK_DimGender_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus]  WITH CHECK ADD  CONSTRAINT [FK_DimMaritalStatus_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus] CHECK CONSTRAINT [FK_DimMaritalStatus_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimOccupation]  WITH CHECK ADD  CONSTRAINT [FK_DimOccupation_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimOccupation] CHECK CONSTRAINT [FK_DimOccupation_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimOrderDate]  WITH CHECK ADD  CONSTRAINT [FK_DimOrderDate_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimOrderDate] CHECK CONSTRAINT [FK_DimOrderDate_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimProduct]  WITH CHECK ADD  CONSTRAINT [FK_DimProduct_DimProductSubCategory] FOREIGN KEY([ProductSubcategoryKey])
REFERENCES [CH01-01-Dimension].[DimProductSubCategory] ([ProductSubcategoryKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimProduct] CHECK CONSTRAINT [FK_DimProduct_DimProductSubCategory]
GO
ALTER TABLE [CH01-01-Dimension].[DimProduct]  WITH CHECK ADD  CONSTRAINT [FK_DimProduct_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimProduct] CHECK CONSTRAINT [FK_DimProduct_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_DimProductCategory_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimProductCategory] CHECK CONSTRAINT [FK_DimProductCategory_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory]  WITH CHECK ADD  CONSTRAINT [FK_DimProductSubCategory_DimProductCategory] FOREIGN KEY([ProductCategoryKey])
REFERENCES [CH01-01-Dimension].[DimProductCategory] ([ProductCategoryKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory] CHECK CONSTRAINT [FK_DimProductSubCategory_DimProductCategory]
GO
ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory]  WITH CHECK ADD  CONSTRAINT [FK_DimProductSubCategory_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory] CHECK CONSTRAINT [FK_DimProductSubCategory_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[DimTerritory]  WITH CHECK ADD  CONSTRAINT [FK_DimTerritory_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[DimTerritory] CHECK CONSTRAINT [FK_DimTerritory_UserAuthorization]
GO
ALTER TABLE [CH01-01-Dimension].[SalesManagers]  WITH CHECK ADD  CONSTRAINT [FK_SalesManagers_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Dimension].[SalesManagers] CHECK CONSTRAINT [FK_SalesManagers_UserAuthorization]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_DimCustomer] FOREIGN KEY([CustomerKey])
REFERENCES [CH01-01-Dimension].[DimCustomer] ([CustomerKey])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimCustomer]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_DimGender] FOREIGN KEY([Gender])
REFERENCES [CH01-01-Dimension].[DimGender] ([Gender])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimGender]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_DimMaritalStatus] FOREIGN KEY([MaritalStatus])
REFERENCES [CH01-01-Dimension].[DimMaritalStatus] ([MaritalStatus])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimMaritalStatus]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_DimOccupation] FOREIGN KEY([OccupationKey])
REFERENCES [CH01-01-Dimension].[DimOccupation] ([OccupationKey])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimOccupation]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_DimOrderDate] FOREIGN KEY([OrderDate])
REFERENCES [CH01-01-Dimension].[DimOrderDate] ([OrderDate])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimOrderDate]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_DimProduct] FOREIGN KEY([ProductKey])
REFERENCES [CH01-01-Dimension].[DimProduct] ([ProductKey])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimProduct]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_DimTerritory] FOREIGN KEY([TerritoryKey])
REFERENCES [CH01-01-Dimension].[DimTerritory] ([TerritoryKey])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimTerritory]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_SalesManagers] FOREIGN KEY([SalesManagerKey])
REFERENCES [CH01-01-Dimension].[SalesManagers] ([SalesManagerKey])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_SalesManagers]
GO
ALTER TABLE [CH01-01-Fact].[Data]  WITH CHECK ADD  CONSTRAINT [FK_Data_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_UserAuthorization]
GO
ALTER TABLE [Process].[WorkflowSteps]  WITH CHECK ADD  CONSTRAINT [FK_WorkFlowSteps_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Process].[WorkflowSteps] CHECK CONSTRAINT [FK_WorkFlowSteps_UserAuthorization]
GO
/****** Object:  StoredProcedure [Process].[usp_ShowWorkflowSteps]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/17/2020
-- Description:	Show workflow steps
-- =============================================
CREATE PROCEDURE [Process].[usp_ShowWorkflowSteps] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT *
	FROM [Process].[WorkFlowSteps];
END
GO
/****** Object:  StoredProcedure [Process].[usp_TrackWorkFlow]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/13/2020
-- Description:	Track work flow
-- =============================================
CREATE   PROCEDURE [Process].[usp_TrackWorkFlow]
    -- Add the parameters for the stored procedure here
    @WorkflowDescription NVARCHAR(100),
    @WorkFlowStepTableRowCount INT,
    @StartingDateTime DATETIME2,
    @EndingDateTime DATETIME2,
    @UserAuthorizationKey INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    INSERT INTO [Process].[WorkflowSteps]
    (
        WorkFlowStepDescription,
        WorkFlowStepTableRowCount,
        StartingDateTime,
        EndingDateTime,
        [Class Time],
        UserAuthorizationKey
    )
    VALUES
    (@WorkflowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, '10:45',
     @UserAuthorizationKey);

END;
GO
/****** Object:  StoredProcedure [Project2].[AddForeignKeysToStarSchemaData]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/13/2020
-- Description:	Add Foreign Keys to the Star Schema
-- =============================================
CREATE   PROCEDURE [Project2].[AddForeignKeysToStarSchemaData] @UserAuthorizationKey INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_DimCustomer
        FOREIGN KEY (CustomerKey)
        REFERENCES [CH01-01-Dimension].DimCustomer (CustomerKey);
    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_DimGender
        FOREIGN KEY (Gender)
        REFERENCES [CH01-01-Dimension].DimGender (Gender);
    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_DimMaritalStatus
        FOREIGN KEY (MaritalStatus)
        REFERENCES [CH01-01-Dimension].DimMaritalStatus (MaritalStatus);
    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_DimOccupation
        FOREIGN KEY (OccupationKey)
        REFERENCES [CH01-01-Dimension].DimOccupation (OccupationKey);
    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_DimOrderDate
        FOREIGN KEY (OrderDate)
        REFERENCES [CH01-01-Dimension].DimOrderDate (OrderDate);
    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_DimProduct
        FOREIGN KEY (ProductKey)
        REFERENCES [CH01-01-Dimension].DimProduct (ProductKey);
    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_DimTerritory
        FOREIGN KEY (TerritoryKey)
        REFERENCES [CH01-01-Dimension].DimTerritory (TerritoryKey);
    ALTER TABLE [CH01-01-Fact].[Data]
    ADD CONSTRAINT FK_Data_SalesManagers
        FOREIGN KEY (SalesManagerKey)
        REFERENCES [CH01-01-Dimension].SalesManagers (SalesManagerKey);
    ALTER TABLE [CH01-01-Dimension].[DimProduct]
    ADD CONSTRAINT FK_DimProduct_DimProductSubCategory
        FOREIGN KEY (ProductSubcategoryKey)
        REFERENCES [CH01-01-Dimension].DimProductSubCategory (ProductSubCategoryKey);
    ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory]
    ADD CONSTRAINT FK_DimProductSubCategory_DimProductCategory
        FOREIGN KEY (ProductCategoryKey)
        REFERENCES [CH01-01-Dimension].DimProductCategory (ProductCategoryKey);
    ALTER TABLE [CH01-01-Dimension].DimCustomer
    ADD CONSTRAINT FK_DimCustomer_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimGender
    ADD CONSTRAINT FK_DimGender_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimMaritalStatus
    ADD CONSTRAINT FK_DimMaritalStatus_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimOccupation
    ADD CONSTRAINT FK_DimOccupation_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimOrderDate
    ADD CONSTRAINT FK_DimOrderDate_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimProduct
    ADD CONSTRAINT FK_DimProduct_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimProductCategory
    ADD CONSTRAINT FK_DimProductCategory_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimProductSubCategory
    ADD CONSTRAINT FK_DimProductSubCategory_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].DimTerritory
    ADD CONSTRAINT FK_DimTerritory_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Dimension].SalesManagers
    ADD CONSTRAINT FK_SalesManagers_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [CH01-01-Fact].Data
    ADD CONSTRAINT FK_Data_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
	ALTER TABLE [Process].[WorkflowSteps]
    ADD CONSTRAINT FK_WorkFlowSteps_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = 0;
    DECLARE @EndingDateTime DATETIME2 = SYSDATETIME();
    EXEC [Process].[usp_TrackWorkFlow] 'Add Foreign Keys',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
END;
GO
/****** Object:  StoredProcedure [Project2].[DropForeignKeysFromStarSchemaData]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/13/2020
-- Description:	Drop the Foreign Keys from the Star Schema
-- =============================================
CREATE   PROCEDURE [Project2].[DropForeignKeysFromStarSchemaData] @UserAuthorizationKey INT
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
GO
/****** Object:  StoredProcedure [Project2].[Load_Data]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jamil Kocacal
-- Create date: 11/14/2020
-- Description:	Populate the Data table
-- =============================================
CREATE PROCEDURE [Project2].[Load_Data] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime DATETIME2;
    SET @StartingDateTime = SYSDATETIME();

    INSERT INTO [CH01-01-Fact].[Data] (
		SalesKey,
		SalesManagerKey,
		OccupationKey,
		TerritoryKey,
		ProductKey,
		CustomerKey,
		ProductCategory,
		SalesManager,
		ProductSubcategory,
		ProductCode,
		ProductName,
		Color,
		ModelName,
		OrderQuantity,
		UnitPrice,
		ProductStandardCost,
		SalesAmount,
		OrderDate,
		[MonthName],
		MonthNumber,
		[Year],
		CustomerName,
		MaritalStatus,
		Gender,
		Education,
		Occupation,
		TerritoryRegion,
		TerritoryCountry,
		TerritoryGroup,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
		)
	SELECT DISTINCT 
		old.Saleskey,
		sm.SalesManagerKey,
		do.OccupationKey,
		dt.TerritoryKey,
		dp.ProductKey,
		dc.CustomerKey,
		old.ProductCategory,
		old.SalesManager,
		old.ProductSubcategory,
		old.ProductCode,
		old.ProductName,
		old.Color,
		old.ModelName,
		old.OrderQuantity,
		old.UnitPrice,
		old.ProductStandardCost,
		old.SalesAmount,
		old.OrderDate,
		old.[MonthName],
		old.MonthNumber,
		old.[Year],
		old.CustomerName,
		old.MaritalStatus,
		old.Gender,
		old.Education,
		old.Occupation,
		old.TerritoryRegion,
		old.TerritoryCountry,
		old.TerritoryGroup,
		@UserAuthorizationKey,
		@DateAdded,
		@DateOfLastUpdate
	FROM 
		FileUpload.OriginallyLoadedData AS old LEFT JOIN 
		[CH01-01-Dimension].DimProduct AS dp 
								on dp.ProductName = old.ProductName AND
								   dp.ProductCode = old.ProductCode LEFT JOIN
		[CH01-01-Dimension].DimTerritory AS dt
								on dt.TerritoryCountry = old.TerritoryCountry AND
									dt.TerritoryGroup = old.TerritoryGroup AND
									dt.TerritoryRegion = old.TerritoryRegion INNER JOIN 
		[CH01-01-Dimension].DimCustomer as dc
								on dc.CustomerName = old.CustomerName LEFT JOIN 
		[CH01-01-Dimension].SalesManagers as sm
								on sm.SalesManager = old.SalesManager and
									sm.Category = old.ProductSubcategory LEFT JOIN
		[CH01-01-Dimension].DimOccupation as do
								on do.Occupation = old.Occupation 
	
    ---VIEW for NEW Table---
    EXEC ('
    DROP VIEW IF EXISTS G10_4.uvw_FactData');
    EXEC ('
    CREATE VIEW G10_4.uvw_FactData AS
    SELECT 
		Saleskey,
		SalesManagerKey,
		OccupationKey,
		TerritoryKey,
		ProductKey,
		CustomerKey,
		ProductCategory,
		SalesManager,
		ProductSubcategory,
		ProductCode,
		ProductName,
		Color,
		ModelName,
		OrderQuantity,
		UnitPrice,
		ProductStandardCost,
		SalesAmount,
		OrderDate,
		[MonthName],
		MonthNumber,
		[Year],
		CustomerName,
		MaritalStatus,
		Gender,
		Education,
		Occupation,
		TerritoryRegion,
		TerritoryCountry,
		TerritoryGroup,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
    FROM [CH01-01-Fact].[Data] ');
    ---VIEW for NEW Table--

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Fact].[Data]);

    EXEC [Process].[usp_TrackWorkFlow] 'Procedure: [Project2].[Load_Data]  loads data into [CH01-01-Fact].[Data]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;


    SELECT *
    FROM G10_4.uvw_FactData;

END;
GO
/****** Object:  StoredProcedure [Project2].[Load_DimCustomer]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marlon Louis
-- Create date: 11/13/2020
-- Description:	Populate the customer table
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimCustomer] @UserAuthorizationKey INT
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
    
    INSERT INTO [CH01-01-Dimension].[DimCustomer] (
        CustomerName, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
    SELECT DISTINCT CustomerName, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
    FROM FileUpload.OriginallyLoadedData 
        

        ---VIEW for NEW Table---
    EXEC('
    DROP VIEW IF EXISTS G10_4.uvw_DimCustomer')
    EXEC('
    CREATE VIEW G10_4.uvw_DimCustomer AS
    SELECT CustomerKey, CustomerName, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimCustomer] ')
    ---VIEW for NEW Table--


    DECLARE @EndingDateTime DATETIME2;
    set @EndingDateTime = SYSDATETIME()

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimCustomer);

    EXEC [Process].[usp_TrackWorkFlow]
        'Procedure: [Project2].[Load_DimCustomer]  loads data into [CH01-01-Dimension].[DimCustomer]',
        @WorkFlowStepTableRowCount,
        @StartingDateTime,
        @EndingDateTime,
        @UserAuthorizationKey

	EXEC('SELECT * FROM G10_4.uvw_DimCustomer')
END



GO
/****** Object:  StoredProcedure [Project2].[Load_DimGender]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marlon Louis
-- Create date: 11/14/2020
-- Description:	Loads data into the Gender table
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimGender] @UserAuthorizationKey INT
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
GO
/****** Object:  StoredProcedure [Project2].[Load_DimMaritalStatus]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Harjit Liyal
-- Create date: 11/14/2020
-- Description:	[Project2].[Load_DimMaritalStatus]
-- =============================================

CREATE PROCEDURE [Project2].[Load_DimMaritalStatus] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime DATETIME2;
    SET @StartingDateTime = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimMaritalStatus]
    (
        MaritalStatus,
        MaritalStatusDescription,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
           MaritalStatus,
           CASE
               WHEN OLD.MaritalStatus = 'M' THEN
                   'Married'
               ELSE
                   'Single'
           END AS MaritalStatusDescription,
           @UserAuthorizationKey,
           @DateAdded,
           @DateOfLastUpdate
    FROM FileUpload.OriginallyLoadedData AS OLD;


    EXEC ('
    DROP VIEW IF EXISTS G10_4.uvw_DimMaritalStatus');
    EXEC ('
    CREATE VIEW G10_4.uvw_DimMaritalStatus AS
    SELECT MaritalStatus, MaritalStatusDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimMaritalStatus] ');
    ---VIEW for NEW Table--
    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimMaritalStatus);

    EXEC [Process].[usp_TrackWorkFlow] 'Procedure: [Project2].[Load_MaritalStatus]  loads data into [CH01-01-Dimension].[DimMaritalStatus]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT * FROM G10_4.uvw_DimMaritalStatus;
END;

GO
/****** Object:  StoredProcedure [Project2].[Load_DimOccupation]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
/****** Object:  StoredProcedure [Project2].[Load_DimOrderDate]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Haibo Liu
-- Create date: 11/14/2020
-- Description:	[Project2].[Load_DimOrderDate]
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimOrderDate]
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



GO
/****** Object:  StoredProcedure [Project2].[Load_DimProduct]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jamil Kocacal
-- Create date: 11/14/2020
-- Description:	Populate the product table
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimProduct] @UserAuthorizationKey INT
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

GO
/****** Object:  StoredProcedure [Project2].[Load_DimProductCategory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Jonathan Eng
-- Create date: 11/14/2020
-- Description: [Project2].[Load_DimProductCategory] 
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimProductCategory] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime DATETIME2;
    SET @StartingDateTime = SYSDATETIME();

    INSERT INTO [CH01-01-Dimension].[DimProductCategory]
    (
        ProductCategory,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
           FileUpload.OriginallyLoadedData.[ProductCategory],
           @UserAuthorizationKey,
           @DateAdded,
           @DateOfLastUpdate
    FROM FileUpload.OriginallyLoadedData;

    ---VIEW for NEW Table---
    EXEC ('
	DROP VIEW IF EXISTS G10_4.uvw_DimProductCategory');
    EXEC ('
	CREATE VIEW G10_4.uvw_DimProductCategory AS
	SELECT ProductCategoryKey, ProductCategory, UserAuthorizationKey, DateAdded, DateOfLastUpdate
	FROM [CH01-01-Dimension].[DimProductCategory] ');
    --====================

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [CH01-01-Dimension].DimProductCategory
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Procedure: [Project2].[Load_DimProductCategory] loads data into [CH01-01-Dimension].[DimProductCategory]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;

    SELECT *
    FROM G10_4.uvw_DimProductCategory;
END;
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProductSubcategory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jonathan Eng
-- Create date: 11/14/2020
-- Description:	[Project2].[Load_DimProductSubcategory]
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimProductSubcategory] @UserAuthorizationKey INT
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
GO
/****** Object:  StoredProcedure [Project2].[Load_DimTerritory]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project2].[Load_DimTerritory]
	@UserAuthorizationKey int

AS
BEGIN
	SET NOCOUNT ON

	DECLARE @DateAdded DATETIME2;
	SET @DateAdded = SYSDATETIME();

	DECLARE @DateOfLastUpdate DATETIME2;
	SET @DateOfLastUpdate = SYSDATETIME();

	DECLARE @StartingDateTime DATETIME2;
	SET @StartingDateTime = SYSDATETIME();

INSERT INTO [CH01-01-Dimension].DimTerritory
([TerritoryRegion], [TerritoryCountry], [TerritoryGroup], UserAuthorizationKey, DateAdded, DateOfLastUpdate)

SELECT DISTINCT FUp.[TerritoryRegion], FUp.[TerritoryCountry], FUp.[TerritoryGroup], @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
FROM FileUpload.OriginallyLoadedData AS FUp


    DECLARE @EndingDateTime DATETIME2;
    set @EndingDateTime = SYSDATETIME()

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].DimTerritory);

	EXEC('
    DROP VIEW IF EXISTS G10_4.uvw_DimTerritory')
    EXEC('
    CREATE VIEW G10_4.uvw_DimTerritory AS
    SELECT TerritoryKey, TerritoryGroup, TerritoryCountry, TerritoryRegion, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[DimTerritory] ')
	

EXEC [Process].[usp_TrackWorkFlow]
        'Procedure: [Project2].[Load_DimTerritory]  loads data into [CH01-01-Dimension].[DimTerritory]',
        @WorkFlowStepTableRowCount,
        @StartingDateTime,
        @EndingDateTime,
        @UserAuthorizationKey


	SELECT *
	FROM G10_4.uvw_DimTerritory
END

GO
/****** Object:  StoredProcedure [Project2].[Load_SalesManagers]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project2].[Load_SalesManagers]
	@UserAuthorizationKey int

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @DateAdded DATETIME2;
	SET @DateAdded = SYSDATETIME();

	DECLARE @DateOfLastUpdate DATETIME2;
	SET @DateOfLastUpdate = SYSDATETIME();

	DECLARE @StartingDateTime DATETIME2;
	SET @StartingDateTime = SYSDATETIME();


INSERT INTO [CH01-01-Dimension].[SalesManagers]
(SalesManager, Category, UserAuthorizationKey, DateAdded, DateOfLastUpdate)

SELECT DISTINCT FileUpload.OriginallyLoadedData.[SalesManager], FileUpload.OriginallyLoadedData.[ProductSubcategory] ,@UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
FROM FileUpload.OriginallyLoadedData

UPDATE [CH01-01-Dimension].[SalesManagers]
SET Office = 'Redmond'
WHERE SalesManager = 'Maurizio Macagno' OR SalesManager = 'Marco Russo';

UPDATE [CH01-01-Dimension].[SalesManagers]
SET Office = 'Seattle'
WHERE SalesManager = 'Alberto Ferrari' OR SalesManager = 'Luis Bonifaz';

    DECLARE @EndingDateTime DATETIME2;
    set @EndingDateTime = SYSDATETIME()

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].SalesManagers);

----New Table View----

	EXEC('
    DROP VIEW IF EXISTS G10_4.uvw_SalesManagers')
    EXEC('
    CREATE VIEW G10_4.uvw_SalesManagers AS
    SELECT SalesManagerKey, SalesManager, Category, Office, UserAuthorizationKey, DateAdded, DateOfLastUpdate
    FROM [CH01-01-Dimension].[SalesManagers] ')

----New Table View----

    EXEC [Process].[usp_TrackWorkFlow]
        'Procedure: [Project2].[Load_SalesManagers]  loads data into [CH01-01-Dimension].[SalesManagers]',
        @WorkFlowStepTableRowCount,
        @StartingDateTime,
        @EndingDateTime,
        @UserAuthorizationKey


	SELECT *
	FROM G10_4.uvw_SalesManagers
END;

GO
/****** Object:  StoredProcedure [Project2].[LoadStarSchemaData]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Project2].[LoadStarSchemaData] @UserAuthorizationKey INT
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
GO
/****** Object:  StoredProcedure [Project2].[ShowTableStatusRowCount]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harjit Liyal
-- Create date: 11/14/2020
-- Description:	[Project2].[ShowTableStatusRowCount]
-- =============================================
CREATE PROCEDURE [Project2].[ShowTableStatusRowCount] @TableStatus VARCHAR(64), @UserAuthorizationKey INT 
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

    DECLARE @EndingDateTime DATETIME2;


    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = 0;

    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimCustomer',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimCustomer
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimGender',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimGender
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimMaritalStatus',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimMaritalStatus
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimOccupation',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimOccupation
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimOrderDate',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimOrderDate
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimProduct',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimProduct
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimProductCategory',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimProductCategory
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimProductSubcategory',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimProductSubcategory
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.DimTerritory',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].DimTerritory
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Dimension.SalesManagers',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Dimension].SalesManagers
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'CH01-01-Fact.Data',
           [Row Count] = COUNT(*)
    FROM [CH01-01-Fact].[Data]
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'DbSecurity.UserAuthorization',
           [Row Count] = COUNT(*)
    FROM [DbSecurity].UserAuthorization
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'Process.WorkflowSteps',
           [Row Count] = COUNT(*)
    FROM [Process].WorkflowSteps;

    SET @EndingDateTime = SYSDATETIME();

    EXEC [Process].[usp_TrackWorkFlow] 'Procedure: [Project2].[ShowStatusRowCount]  loads data into [Project2].[ShowTableStatusRowCount]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;


END;

GO
/****** Object:  StoredProcedure [Project2].[TruncateStarSchemaData]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/13/2020
-- Description:	Truncate StarSchemaData
-- =============================================
CREATE   PROCEDURE [Project2].[TruncateStarSchemaData]
	@UserAuthorizationKey int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

	TRUNCATE TABLE [CH01-01-Dimension].DimCustomer;
	ALTER SEQUENCE PkSequence.DimCustomerSequenceObject RESTART WITH 1;
	TRUNCATE TABLE [CH01-01-Dimension].DimGender;
	TRUNCATE TABLE [CH01-01-Dimension].DimMaritalStatus;
	TRUNCATE TABLE [CH01-01-Dimension].DimOccupation;
	ALTER SEQUENCE PkSequence.OccupationSequenceObject RESTART WITH 1;
	TRUNCATE TABLE [CH01-01-Dimension].DimOrderDate;
	TRUNCATE TABLE [CH01-01-Dimension].DimProduct;
	ALTER SEQUENCE PkSequence.DimProductSequenceObject RESTART WITH 1;
	TRUNCATE TABLE [CH01-01-Dimension].DimProductCategory;
	ALTER SEQUENCE PkSequence.DimProductCategorySequenceObject RESTART WITH 1;
	TRUNCATE TABLE [CH01-01-Dimension].DimProductSubCategory;
	ALTER SEQUENCE PkSequence.DimProductSubCategorySequenceObject RESTART WITH 1;
	TRUNCATE TABLE [CH01-01-Dimension].DimTerritory;
	ALTER SEQUENCE PkSequence.DimTerritorySequenceObject RESTART WITH 1;
	TRUNCATE TABLE [CH01-01-Dimension].SalesManagers;
	ALTER SEQUENCE PkSequence.SalesManagersSequenceObject RESTART WITH 1;
	TRUNCATE TABLE [CH01-01-Fact].Data;
	ALTER SEQUENCE PkSequence.DataSequenceObject RESTART WITH 1;

	DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = 0;
    DECLARE @EndingDateTime DATETIME2 = SYSDATETIME();
    EXEC [Process].[usp_TrackWorkFlow] 'Truncate Data',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
end
GO
/****** Object:  StoredProcedure [Utils].[DropProcsInCSCI331FinalProject]    Script Date: 11/18/2020 6:48:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/15/2020
-- Description:	Drop procs
-- =============================================
CREATE procedure [Utils].[DropProcsInCSCI331FinalProject] @UserAuthorizationKey INT
as
begin
    set nocount on;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();
    --select concat('drop prodcedure if exists  ', schema_name(o.schema_id), '.', name)
    --from sys.objects as o
    --where o.type = 'P'
    --      and o.schema_id = 9;

    drop proc if exists Project2.Load_SalesManagers;
    drop proc if exists Project2.Load_DimProductSubcategory;
    drop proc if exists Project2.Load_DimProductCategory;
    drop proc if exists Project2.Load_DimGender;
    drop proc if exists Project2.Load_DimMaritalStatus;
    drop proc if exists Project2.Load_DimOccupation;
    drop proc if exists Project2.Load_DimOrderDate;
    drop proc if exists Project2.Load_DimTerritory;
    drop proc if exists Project2.Load_DimProduct;
    drop proc if exists Project2.Load_DimCustomer;
    drop proc if exists Project2.Load_Data;
    drop proc if exists Project2.TruncateStarSchemaData;
    drop proc if exists Project2.LoadStarSchemaData;
	DROP PROC IF EXISTS Project2.AddForeignKeysToStarSchemaData;
	DROP PROC IF EXISTS Project2.DropForeignKeysFromStarSchemaData;
	DROP PROC IF EXISTS Project2.ShowTableStatusRowCount;

	DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = 0;
	DECLARE @EndingDateTime DATETIME2 = SYSDATETIME();
    EXEC [Process].[usp_TrackWorkFlow] 'Drop Procedures',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
	
	DROP PROC IF EXISTS Process.usp_TrackWorkFlow;
end;
GO
