/****** Object:  Schema [Course]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Course]
GO
/****** Object:  Schema [DbSecurity]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [DbSecurity]
GO
/****** Object:  Schema [Department]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Department]
GO
/****** Object:  Schema [G10_4]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [G10_4]
GO
/****** Object:  Schema [groupnDim]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [groupnDim]
GO
/****** Object:  Schema [groupnFACT]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [groupnFACT]
GO
/****** Object:  Schema [groupnUploadfile]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [groupnUploadfile]
GO
/****** Object:  Schema [Location]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Location]
GO
/****** Object:  Schema [Process]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Process]
GO
/****** Object:  Schema [Project3]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Project3]
GO
/****** Object:  Schema [QC]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [QC]
GO
/****** Object:  Schema [Udt]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Udt]
GO
/****** Object:  Schema [Upload]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Upload]
GO
/****** Object:  Schema [Uploadfile]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE SCHEMA [Uploadfile]
GO
/****** Object:  UserDefinedDataType [Udt].[BuildingLocation]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[BuildingLocation] FROM [nvarchar](50) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[ClassTime]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[ClassTime] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[Count]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[Count] FROM [int] NULL
GO
/****** Object:  UserDefinedDataType [Udt].[CourseCode]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[CourseCode] FROM [varchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[CourseDesc]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[CourseDesc] FROM [varchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[CourseName]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[CourseName] FROM [varchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[DateOf]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[DateOf] FROM [datetime2](7) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[DayOfWeek]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[DayOfWeek] FROM [nvarchar](50) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[DepartmentName]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[DepartmentName] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[Description]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[Description] FROM [nvarchar](50) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[IndividualProject]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[IndividualProject] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[IntValue]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[IntValue] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[Location]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[Location] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[ModeOfInstruction]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[ModeOfInstruction] FROM [nvarchar](50) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[Name]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[Name] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[RoomLocation]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[RoomLocation] FROM [nvarchar](50) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[Section]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[Section] FROM [varchar](50) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[SurrogateKeyInt]    Script Date: 12/11/2020 2:39:53 AM ******/
CREATE TYPE [Udt].[SurrogateKeyInt] FROM [int] NOT NULL
GO
/****** Object:  Table [groupnUploadfile].[CoursesSpring2017]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [groupnUploadfile].[CoursesSpring2017](
	[Sec] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
	[Course (hr, crd)] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Day] [varchar](50) NULL,
	[Time] [varchar](50) NULL,
	[Instructor] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[Enrolled] [varchar](50) NULL,
	[Limit] [varchar](50) NULL,
	[Mode of Instruction] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_RoomLocation]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_RoomLocation] AS SELECT DISTINCT COALESCE(NULLIF([Location],' '), 'AA TBA') AS RoomLocation FROM groupnUploadfile.CoursesSpring2017;
GO
/****** Object:  View [G10_4].[uvw_BuildingRoomNumber]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_BuildingRoomNumber] AS
	SELECT SUBSTRING([RoomLocation], 3, 100) AS RoomNumber
	FROM G10_4.uvw_RoomLocation;
GO
/****** Object:  View [G10_4].[uvw_Department]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Department] AS SELECT DISTINCT SUBSTRING([Course (hr, crd)], 0, CHARINDEX(' ', [Course (hr, crd)])) AS [DepartmentName]
    FROM groupnUploadfile.CoursesSpring2017;
GO
/****** Object:  View [G10_4].[uvw_Department1]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Department1] AS SELECT DISTINCT COALESCE(NULLIF([DepartmentName],''), 'TBA') AS DepartmentName FROM G10_4.uvw_Department
GO
/****** Object:  View [G10_4].[uvw_Instructor_Temp1]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Instructor_Temp1] AS
		SELECT DISTINCT 
			CASE WHEN LEN(Instructor)<2 THEN 'TBA'
			ELSE
			COALESCE(
				NULLIF(
					SUBSTRING(Instructor, 1, 
						CASE when CHARINDEX(',', Instructor) = 0 OR CHARINDEX(' ', Instructor) = 0 THEN len(Instructor)
						ELSE	  CHARINDEX(',', Instructor)-1 END)
					,','), 'TBA')					
					END AS InstructorLastName1,
			COALESCE(NULLIF(SUBSTRING(Instructor,    CHARINDEX(' ', Instructor) + 1, LEN(Instructor)) ,','), 'TBA') AS InstructorFirstName1,
			COALESCE(NULLIF(Instructor,','), 'TBA') AS InstructorFullName1,
			COALESCE(NULLIF(SUBSTRING([Course (hr, crd)], 0, CHARINDEX(' ', [Course (hr, crd)])),' '), 'TBA') AS DepartmentName1
		FROM groupnUploadfile.CoursesSpring2017
GO
/****** Object:  View [G10_4].[uvw_Instructor_Temp2]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Instructor_Temp2] AS

		SELECT DISTINCT 
			COALESCE(NULLIF(InstructorLastName1,' '), 'TBA') AS InstructorLastName2,
			COALESCE(NULLIF(InstructorFirstName1,' '), 'TBA') AS InstructorFirstName2,
			COALESCE(NULLIF(InstructorFullName1,' '), 'TBA') AS InstructorFullName2,
			COALESCE(NULLIF(DepartmentName1,' '), 'TBA') AS DepartmentName2
		FROM G10_4.uvw_Instructor_Temp1
GO
/****** Object:  View [G10_4].[uvw_Instructor_Temp3]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Instructor_Temp3] AS
		SELECT DISTINCT DepartmentName2, ROW_NUMBER() OVER(ORDER BY DepartmentName2) AS DepartmentKey
		FROM G10_4.uvw_Instructor_Temp2
		GROUP BY DepartmentName2
GO
/****** Object:  View [G10_4].[uvw_BuildingLocation1]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_BuildingLocation1]
				AS
		SELECT DISTINCT
       ROW_NUMBER() OVER( ORDER BY Sec ) AS id,
       COALESCE(NULLIF([Location], ' '), 'TBA') AS Location,
       COALESCE(NULLIF(SUBSTRING([Location], 1, 2), ' '), 'TBA') AS BuildingLocation
		FROM groupnUploadfile.CoursesSpring2017;
		
        
		
GO
/****** Object:  View [G10_4].[uvw_BuildingLocation2]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_BuildingLocation2]
				AS
				SELECT DISTINCT
				Location,
				BuildingLocation
				FROM G10_4.uvw_BuildingLocation1
GO
/****** Object:  View [G10_4].[uvw_BuildingLocation3]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_BuildingLocation3]
				AS
				SELECT ROW_NUMBER() OVER( ORDER BY Location ) AS id,
				Location,
				BuildingLocation
				FROM G10_4.uvw_BuildingLocation2
GO
/****** Object:  Table [Location].[RoomLocation]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Location].[RoomLocation](
	[RoomLocationKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[RoomLocation] [Udt].[RoomLocation] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
	[DateOfLastUpdate] [Udt].[DateOf] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomLocationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_BuildingLocation4]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_BuildingLocation4]
				AS
				SELECT A.[Location],
				A.BuildingLocation,
				B.RoomLocation,
				B.RoomLocationKey
				FROM G10_4.uvw_BuildingLocation3 AS A FULL OUTER JOIN Location.RoomLocation AS B ON A.id = B.RoomLocationKey 
GO
/****** Object:  Table [Course].[ModeofInstruction]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[ModeofInstruction](
	[ModeOfInstructionKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[ModeOfInstruction] [Udt].[ModeOfInstruction] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
	[DateOfLastUpdate] [Udt].[DateOf] NULL,
PRIMARY KEY CLUSTERED 
(
	[ModeOfInstructionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Course].[Course]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[Course](
	[CourseKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[CourseName] [Udt].[CourseName] NULL,
	[CourseDescription] [Udt].[CourseDesc] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
	[DateOfLastUpdate] [Udt].[DateOf] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [G10_4].[uvw_Class]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Class] AS 
		(SELECT c.CourseKey,
		a.Sec,
		a.Code,
		SUBSTRING(a.[Course (hr, crd)], 1, 8) as Course,
		c.CourseDescription,
		CASE WHEN a.Instructor = ',' THEN 'TBA' ELSE a.Instructor END as Instructor,
		CASE WHEN a.DAY = ' ' THEN 'TBA' ELSE a.DAY END as Day,
		CASE WHEN a.time = '-' THEN 'TBA' ELSE a.TIME END as Time,
		CASE WHEN a.[Course (hr, crd)] != ' ' THEN SUBSTRING([Course (hr, crd)], CHARINDEX(',', [Course (hr, crd)])+2, (LEN([Course (hr, crd)])-(CHARINDEX(',', [Course (hr, crd)])+2))) END as NumCredits,
		a.Enrolled,
		a.Limit,
		CASE WHEN CAST(a.Enrolled AS INT) > CAST(a.Limit AS INT) then CAST(a.Enrolled AS INT) - CAST(a.Limit AS INT) ELSE 0 END as OverTally,
		mo.ModeOfInstructionKey,
		CASE WHEN a.[Mode of Instruction]	IS NULL THEN 'TBA' ELSE a.[Mode of Instruction] END as ModeOfInstruction

		FROM groupnUploadfile.CoursesSpring2017 as a inner join [Course].[Course] as c on a.[Course (hr, crd)] = c.CourseName 
		INNER JOIN Course.ModeOfInstruction as mo on a.[Mode of Instruction] = mo.ModeOfInstruction where a.description != ' ');
GO
/****** Object:  View [G10_4].[uvw_ModeOfInstruction]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_ModeOfInstruction] AS SELECT DISTINCT COALESCE(NULLIF([Mode of Instruction],''), 'TBA') AS ModeOfInstruction FROM groupnUploadfile.CoursesSpring2017;
GO
/****** Object:  View [G10_4].[uvw_Course]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

		CREATE VIEW [G10_4].[uvw_Course] AS

		SELECT DISTINCT 
			[Course (hr, crd)] as CourseName,
			Description AS Description
	FROM groupnUploadfile.CoursesSpring2017;
GO
/****** Object:  View [G10_4].[uvw_Course1]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Course1] AS
		   SELECT DISTINCT 
				COALESCE(NULLIF([CourseName],''), 'TBA') AS CourseName,
				COALESCE(NULLIF([Description],''), 'TBA') AS Description FROM G10_4.uvw_Course
GO
/****** Object:  View [G10_4].[uvw_Instructor]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [G10_4].[uvw_Instructor] AS
		SELECT a.InstructorLastName2 as InstructorLastName, 
			a.InstructorFirstName2 as InstructorFirstName,
			a.InstructorFullName2 as InstructorFullName,
			a.DepartmentName2 as DepartmentName,
			b.DepartmentKey as DepartmentKey
		FROM G10_4.uvw_Instructor_Temp2 as a
		INNER JOIN G10_4.uvw_Instructor_Temp3 as b
		on a.DepartmentName2 = b.DepartmentName2
GO
/****** Object:  Table [Course].[Class]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[Class](
	[ClassKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[CourseKey] [Udt].[SurrogateKeyInt] NULL,
	[Section] [Udt].[Section] NULL,
	[CourseCode] [Udt].[CourseCode] NULL,
	[CourseName] [Udt].[CourseName] NULL,
	[CourseDescription] [Udt].[CourseDesc] NULL,
	[InstructorFullName] [Udt].[Name] NULL,
	[Day] [Udt].[DayOfWeek] NULL,
	[Hours] [Udt].[IntValue] NULL,
	[NumberOfCredits] [Udt].[IntValue] NULL,
	[NumberEnrolled] [Udt].[IntValue] NULL,
	[Limit] [Udt].[IntValue] NULL,
	[OverTally] [Udt].[Count] NULL,
	[ModeOfInstructionKey] [Udt].[SurrogateKeyInt] NULL,
	[ModeOfInstruction] [Udt].[ModeOfInstruction] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
	[DateOfLastUpdate] [Udt].[DateOf] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DbSecurity].[UserAuthorization]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DbSecurity].[UserAuthorization](
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[ClassTime] [Udt].[ClassTime] NULL,
	[IndividualProject] [Udt].[IndividualProject] NULL,
	[GroupMemberLastName] [Udt].[Name] NOT NULL,
	[GroupMemberFirstName] [Udt].[Name] NOT NULL,
	[GroupName] [Udt].[Name] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserAuthorizationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Department].[Department]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Department].[Department](
	[DepartmentKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [Udt].[DepartmentName] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
	[DateOfLastUpdate] [Udt].[DateOf] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Department].[Instructor]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Department].[Instructor](
	[InstructorKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[InstructorFirstName] [Udt].[Name] NULL,
	[InstructorLastName] [Udt].[Name] NULL,
	[InstructorFullName] [Udt].[Name] NULL,
	[DepartmentName] [Udt].[DepartmentName] NULL,
	[DepartmentKey] [Udt].[SurrogateKeyInt] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
	[DateOfLastUpdate] [Udt].[DateOf] NULL,
PRIMARY KEY CLUSTERED 
(
	[InstructorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Location].[BuildingLocation]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Location].[BuildingLocation](
	[BuildingKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[BuildingLocation] [Udt].[Location] NOT NULL,
	[RoomLocationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[RoomLocation] [Udt].[Location] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
	[DateAdded] [Udt].[DateOf] NULL,
	[DateOfLastUpdate] [Udt].[DateOf] NULL,
PRIMARY KEY CLUSTERED 
(
	[BuildingKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Process].[WorkflowSteps]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[WorkflowSteps](
	[WorkFlowStepKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[WorkFlowStepDescription] [Udt].[Description] NOT NULL,
	[WorkFlowStepTableRowCount] [Udt].[Count] NULL,
	[StartingDateTime] [Udt].[DateOf] NULL,
	[EndingDateTime] [Udt].[DateOf] NULL,
	[Class Time] [Udt].[ClassTime] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkFlowStepKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Course].[Class] ADD  DEFAULT ('TBA') FOR [ModeOfInstruction]
GO
ALTER TABLE [Course].[Class] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Course].[Class] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [Course].[Course] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Course].[Course] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [Course].[ModeofInstruction] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Course].[ModeofInstruction] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('10:45') FOR [ClassTime]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('PROJECT 3') FOR [IndividualProject]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('GROUP 4') FOR [GroupName]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Department].[Department] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Department].[Department] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [Department].[Instructor] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Department].[Instructor] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [Location].[BuildingLocation] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Location].[BuildingLocation] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [Location].[RoomLocation] ADD  DEFAULT ('AA TBA') FOR [RoomLocation]
GO
ALTER TABLE [Location].[RoomLocation] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Location].[RoomLocation] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [Course].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_Course] FOREIGN KEY([CourseKey])
REFERENCES [Course].[Course] ([CourseKey])
GO
ALTER TABLE [Course].[Class] CHECK CONSTRAINT [FK_Class_Course]
GO
ALTER TABLE [Course].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_ModeOfInstruction] FOREIGN KEY([ModeOfInstructionKey])
REFERENCES [Course].[ModeofInstruction] ([ModeOfInstructionKey])
GO
ALTER TABLE [Course].[Class] CHECK CONSTRAINT [FK_Class_ModeOfInstruction]
GO
ALTER TABLE [Course].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[Class] CHECK CONSTRAINT [FK_Class_UserAuthorization]
GO
ALTER TABLE [Course].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[Course] CHECK CONSTRAINT [FK_Course_UserAuthorization]
GO
ALTER TABLE [Course].[ModeofInstruction]  WITH CHECK ADD  CONSTRAINT [FK_ModeOfInstruction_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[ModeofInstruction] CHECK CONSTRAINT [FK_ModeOfInstruction_UserAuthorization]
GO
ALTER TABLE [Department].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Department].[Department] CHECK CONSTRAINT [FK_Department_UserAuthorization]
GO
ALTER TABLE [Department].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Department] FOREIGN KEY([DepartmentKey])
REFERENCES [Department].[Department] ([DepartmentKey])
GO
ALTER TABLE [Department].[Instructor] CHECK CONSTRAINT [FK_Instructor_Department]
GO
ALTER TABLE [Department].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Department].[Instructor] CHECK CONSTRAINT [FK_Instructor_UserAuthorization]
GO
ALTER TABLE [Location].[BuildingLocation]  WITH CHECK ADD  CONSTRAINT [FK_BuildingLocation_RoomLocation] FOREIGN KEY([RoomLocationKey])
REFERENCES [Location].[RoomLocation] ([RoomLocationKey])
GO
ALTER TABLE [Location].[BuildingLocation] CHECK CONSTRAINT [FK_BuildingLocation_RoomLocation]
GO
ALTER TABLE [Location].[BuildingLocation]  WITH CHECK ADD  CONSTRAINT [FK_BuildingLocation_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Location].[BuildingLocation] CHECK CONSTRAINT [FK_BuildingLocation_UserAuthorization]
GO
ALTER TABLE [Location].[RoomLocation]  WITH CHECK ADD  CONSTRAINT [FK_RoomLocation_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Location].[RoomLocation] CHECK CONSTRAINT [FK_RoomLocation_UserAuthorization]
GO
ALTER TABLE [Process].[WorkflowSteps]  WITH CHECK ADD  CONSTRAINT [FK_WorkFlowSteps_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Process].[WorkflowSteps] CHECK CONSTRAINT [FK_WorkFlowSteps_UserAuthorization]
GO
/****** Object:  StoredProcedure [Process].[usp_ShowWorkflowSteps]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/1/2020>
-- Description:	<Show Work Flow Steps>
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
/****** Object:  StoredProcedure [Process].[usp_TrackWorkFlow]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/1/2020>
-- Description:	<Track Work Flow>
-- =============================================
CREATE PROCEDURE [Process].[usp_TrackWorkFlow]
    -- Add the parameters for the stored procedure here
    @WorkflowDescription [Udt].[Description],
    @WorkFlowStepTableRowCount [Udt].[Count],
    @StartingDateTime [Udt].[DateOf],
    @EndingDateTime [Udt].[DateOf],
    @UserAuthorizationKey [Udt].[SurrogateKeyInt]
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
/****** Object:  StoredProcedure [Project3].[AddForeignKeys]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/7/2020>
-- Description:	<Add Foreign Keys>
-- =============================================
CREATE PROCEDURE [Project3].[AddForeignKeys] @UserAuthorizationKey INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

    ALTER TABLE [Course].[Class]
    ADD CONSTRAINT FK_Class_ModeOfInstruction
        FOREIGN KEY (ModeOfInstructionKey)
        REFERENCES [Course].[ModeOfInstruction] (ModeOfInstructionKey);
    ALTER TABLE [Course].[Class]
    ADD CONSTRAINT FK_Class_Course
        FOREIGN KEY (CourseKey)
        REFERENCES [Course].[Course] (CourseKey);
    ALTER TABLE [Department].[Instructor]
    ADD CONSTRAINT FK_Instructor_Department
        FOREIGN KEY (DepartmentKey)
        REFERENCES [Department].[Department] (DepartmentKey);
    ALTER TABLE [Location].[BuildingLocation]
    ADD CONSTRAINT FK_BuildingLocation_RoomLocation
        FOREIGN KEY (RoomLocationKey)
        REFERENCES [Location].[RoomLocation] (RoomLocationKey);
    ALTER TABLE [Process].[WorkflowSteps]
    ADD CONSTRAINT FK_WorkFlowSteps_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [Course].[Class]
    ADD CONSTRAINT FK_Class_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [Course].[Course]
    ADD CONSTRAINT FK_Course_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [Course].[ModeOfInstruction]
    ADD CONSTRAINT FK_ModeOfInstruction_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [Department].[Department]
    ADD CONSTRAINT FK_Department_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [Department].[Instructor]
    ADD CONSTRAINT FK_Instructor_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [Location].[BuildingLocation]
    ADD CONSTRAINT FK_BuildingLocation_UserAuthorization
        FOREIGN KEY (UserAuthorizationKey)
        REFERENCES [DbSecurity].UserAuthorization (UserAuthorizationKey);
    ALTER TABLE [Location].[RoomLocation]
    ADD CONSTRAINT FK_RoomLocation_UserAuthorization
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
/****** Object:  StoredProcedure [Project3].[DropForeignKeys]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/7/2020>
-- Description:	<Drop Foreign Keys>
-- =============================================
CREATE PROCEDURE [Project3].[DropForeignKeys] @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

    ALTER TABLE [Course].[Class]
    DROP CONSTRAINT FK_Class_ModeOfInstruction
    ALTER TABLE [Course].[Class]
    DROP CONSTRAINT FK_Class_Course
    ALTER TABLE [Department].[Instructor]
    DROP CONSTRAINT FK_Instructor_Department
    ALTER TABLE [Location].[BuildingLocation]
    DROP CONSTRAINT FK_BuildingLocation_RoomLocation
    ALTER TABLE [Process].[WorkflowSteps]
    DROP CONSTRAINT FK_WorkFlowSteps_UserAuthorization
    ALTER TABLE [Course].[Class]
    DROP CONSTRAINT FK_Class_UserAuthorization
    ALTER TABLE [Course].[Course]
    DROP CONSTRAINT FK_Course_UserAuthorization
    ALTER TABLE [Course].[ModeOfInstruction]
    DROP CONSTRAINT FK_ModeOfInstruction_UserAuthorization
    ALTER TABLE [Department].[Department]
    DROP CONSTRAINT FK_Department_UserAuthorization
    ALTER TABLE [Department].[Instructor]
    DROP CONSTRAINT FK_Instructor_UserAuthorization
    ALTER TABLE [Location].[BuildingLocation]
    DROP CONSTRAINT FK_BuildingLocation_UserAuthorization
    ALTER TABLE [Location].[RoomLocation]
    DROP CONSTRAINT FK_RoomLocation_UserAuthorization

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
/****** Object:  StoredProcedure [Project3].[Load_BuildingLocation]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Haibo Liu>
-- Create date: <12/3/2020>
-- Description:	<Load Data Into BuildingLocation>
-- =============================================
CREATE PROCEDURE [Project3].[Load_BuildingLocation] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
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
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation1
				AS
		SELECT DISTINCT
       ROW_NUMBER() OVER( ORDER BY Sec ) AS id,
       COALESCE(NULLIF([Location], '' ''), ''TBA'') AS Location,
       COALESCE(NULLIF(SUBSTRING([Location], 1, 2), '' ''), ''TBA'') AS BuildingLocation
		FROM groupnUploadfile.CoursesSpring2017;
		
        
		'
	EXEC (@SQL) 
	

	DECLARE @SQL2 AS NVARCHAR(MAX)
	SET @SQL2 = 'CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation2
				AS
				SELECT DISTINCT
				Location,
				BuildingLocation
				FROM G10_4.uvw_BuildingLocation1'
	EXEC (@SQL2) 

	DECLARE @SQL3 AS NVARCHAR(MAX)
	SET @SQL3 ='CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation3
				AS
				SELECT ROW_NUMBER() OVER( ORDER BY Location ) AS id,
				Location,
				BuildingLocation
				FROM G10_4.uvw_BuildingLocation2'
	EXEC (@SQL3) 

	DECLARE @SQL4 AS NVARCHAR(MAX)
	SET @SQL4 = 'CREATE OR ALTER VIEW G10_4.uvw_BuildingLocation4
				AS
				SELECT A.[Location],
				A.BuildingLocation,
				B.RoomLocation,
				B.RoomLocationKey
				FROM G10_4.uvw_BuildingLocation3 AS A FULL OUTER JOIN Location.RoomLocation AS B ON A.id = B.RoomLocationKey '
	EXEC (@SQL4) 

	INSERT INTO [Location].BuildingLocation(BuildingLocation,RoomLocation,RoomLocationKey,UserAuthorizationKey,DateAdded,DateOfLastUpdate)
	SELECT DISTINCT 
        BuildingLocation,RoomLocation,RoomLocationKey,@UserAuthorizationKey,@DateAdded,@DateOfLastUpdate 
		FROM G10_4.uvw_BuildingLocation4 




    DECLARE @EndingDateTime [Udt].[DateOf];
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Location].[BuildingLocation]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Location].[BuildingLocation]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Location].[BuildingLocation];
END;
GO
/****** Object:  StoredProcedure [Project3].[Load_Class]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marlon Louis
-- Create date: <12/2/2020>
-- Description:	<Load Data Into Class>
-- =============================================
CREATE PROCEDURE [Project3].[Load_Class] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

	TRUNCATE TABLE Course.Class

    DECLARE @DateAdded [Udt].[DateOf];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[DateOf];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[DateOf];
    SET @StartingDateTime = SYSDATETIME();

	--VIEW
	DECLARE @SQL AS NVARCHAR(MAX)
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_Class AS 
		(SELECT c.CourseKey,
		a.Sec,
		a.Code,
		SUBSTRING(a.[Course (hr, crd)], 1, 8) as Course,
		c.CourseDescription,
		CASE WHEN a.Instructor = '','' THEN ''TBA'' ELSE a.Instructor END as Instructor,
		CASE WHEN a.DAY = '' '' THEN ''TBA'' ELSE a.DAY END as Day,
		CASE WHEN a.time = ''-'' THEN ''TBA'' ELSE a.TIME END as Time,
		CASE WHEN a.[Course (hr, crd)] != '' '' THEN SUBSTRING([Course (hr, crd)], CHARINDEX('','', [Course (hr, crd)])+2, (LEN([Course (hr, crd)])-(CHARINDEX('','', [Course (hr, crd)])+2))) END as NumCredits,
		a.Enrolled,
		a.Limit,
		CASE WHEN CAST(a.Enrolled AS INT) > CAST(a.Limit AS INT) then CAST(a.Enrolled AS INT) - CAST(a.Limit AS INT) ELSE 0 END as OverTally,
		mo.ModeOfInstructionKey,
		CASE WHEN a.[Mode of Instruction]	IS NULL THEN ''TBA'' ELSE a.[Mode of Instruction] END as ModeOfInstruction

		FROM groupnUploadfile.CoursesSpring2017 as a inner join [Course].[Course] as c on a.[Course (hr, crd)] = c.CourseName 
		INNER JOIN Course.ModeOfInstruction as mo on a.[Mode of Instruction] = mo.ModeOfInstruction where a.description != '' '');'
		
    EXEC (@SQL)

	INSERT INTO Course.Class
(
	CourseKey,
	Section,
	CourseCode,
	CourseName,
	CourseDescription,
    InstructorFullName,
    Day,
    Hours,
    NumberOfCredits,
    NumberEnrolled,
    Limit,
    OverTally,
	ModeOfInstructionKey,
	ModeOfInstruction,
    UserAuthorizationKey,
	DateAdded,
	DateOfLastUpdate
) 
	SELECT a.CourseKey, a.Sec, a.Code, a.Course, a.CourseDescription, a.instructor, a.day, a.time, a.NumCredits, a.enrolled, a.limit, a.overtally, a.ModeOfInstructionKey, a.ModeOfInstruction, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
	FROM G10_4.uvw_Class AS a;

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Course].[Class]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Project3].[Class]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    
	SELECT * FROM [Course].[Class];
    
END;
GO
/****** Object:  StoredProcedure [Project3].[Load_Course]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Jamil Kocacal
-- Create date: 12/3/2020
-- Description: <Load Data into Course>; [Project3].[Load_Course], 
-- =============================================
CREATE     PROCEDURE [Project3].[Load_Course] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded [Udt].[DateOf];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[DateOf];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[DateOf];
    SET @StartingDateTime = SYSDATETIME();
	/*----- DELETE -----*/
	DECLARE @SQL2 AS NVARCHAR(MAX)
    SET @SQL2=N'
		DROP VIEW IF EXISTS G10_4.uvw_Course
		DROP VIEW IF EXISTS G10_4.uvw_Course1'
    EXEC (@SQL2)
	/*=============VIEW=================*/
	DECLARE @SQL AS NVARCHAR(MAX)
    SET @SQL=N'
		CREATE VIEW G10_4.uvw_Course AS

		SELECT DISTINCT 
			[Course (hr, crd)] as CourseName,
			Description AS Description
	FROM groupnUploadfile.CoursesSpring2017;'
    EXEC (@SQL)
	/*====================================*/
	DECLARE @SQL3 AS NVARCHAR(MAX);
    SET @SQL3
        = N'CREATE OR ALTER VIEW G10_4.uvw_Course1 AS
		   SELECT DISTINCT 
				COALESCE(NULLIF([CourseName],''''), ''TBA'') AS CourseName,
				COALESCE(NULLIF([Description],''''), ''TBA'') AS Description FROM G10_4.uvw_Course';
    EXEC (@SQL3);

	INSERT INTO Course.Course(CourseName, CourseDescription, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
	SELECT  [CourseName], [Description], @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
	FROM G10_4.uvw_Course1;

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [Course].[Course]);
	
    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Project3].[ModeOfInstruction]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Course].[Course];
END;
GO
/****** Object:  StoredProcedure [Project3].[Load_Department]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Harjit Liyal>
-- Create date: <12/2/2020>
-- Description:	<Load Data Into Department>
-- =============================================
CREATE PROCEDURE [Project3].[Load_Department] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded [Udt].[DateOf];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[DateOf];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[DateOf];
    SET @StartingDateTime = SYSDATETIME();

    DECLARE @SQL AS NVARCHAR(MAX);

    SET @SQL
        = N'CREATE OR ALTER VIEW G10_4.uvw_Department AS SELECT DISTINCT SUBSTRING([Course (hr, crd)], 0, CHARINDEX('' '', [Course (hr, crd)])) AS [DepartmentName]
    FROM groupnUploadfile.CoursesSpring2017;';
    EXEC (@SQL);


    DECLARE @SQL2 AS NVARCHAR(MAX);
    SET @SQL2
        = N'CREATE OR ALTER VIEW G10_4.uvw_Department1 AS SELECT DISTINCT COALESCE(NULLIF([DepartmentName],''''), ''TBA'') AS DepartmentName FROM G10_4.uvw_Department';
    EXEC (@SQL2);

    INSERT INTO Department.Department
    (
        DepartmentName,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DepartmentName,
           @UserAuthorizationKey,
           @DateAdded,
           @DateOfLastUpdate
    FROM G10_4.uvw_Department1;

    DECLARE @EndingDateTime DATETIME2;
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Department].[Department]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Department].[Department]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Department].[Department];
END;
GO
/****** Object:  StoredProcedure [Project3].[Load_Instructor]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Jonathan Eng
-- Create date: 12/9/2020
-- Description: <Load Data into Instructor>; [Project3].[Load_Instructor], 
-- =============================================
CREATE   PROCEDURE [Project3].[Load_Instructor] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateAdded [Udt].[Dateof];
    SET @DateAdded = SYSDATETIME();

    DECLARE @DateOfLastUpdate [Udt].[Dateof];
    SET @DateOfLastUpdate = SYSDATETIME();

    DECLARE @StartingDateTime [Udt].[Dateof];
    SET @StartingDateTime = SYSDATETIME();
	/*=============VIEW=================*/
	DECLARE @SQL AS NVARCHAR(MAX)
	DROP VIEW IF EXISTS G10_4.uvw_Instructor
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_Instructor_Temp1 AS
		SELECT DISTINCT 
			CASE WHEN LEN(Instructor)<2 THEN ''TBA''
			ELSE
			COALESCE(
				NULLIF(
					SUBSTRING(Instructor, 1, 
						CASE when CHARINDEX('','', Instructor) = 0 OR CHARINDEX('' '', Instructor) = 0 THEN len(Instructor)
						ELSE	  CHARINDEX('','', Instructor)-1 END)
					,'',''), ''TBA'')					
					END AS InstructorLastName1,
			COALESCE(NULLIF(SUBSTRING(Instructor,    CHARINDEX('' '', Instructor) + 1, LEN(Instructor)) ,'',''), ''TBA'') AS InstructorFirstName1,
			COALESCE(NULLIF(Instructor,'',''), ''TBA'') AS InstructorFullName1,
			COALESCE(NULLIF(SUBSTRING([Course (hr, crd)], 0, CHARINDEX('' '', [Course (hr, crd)])),'' ''), ''TBA'') AS DepartmentName1
		FROM groupnUploadfile.CoursesSpring2017'
    EXEC (@SQL)

	DECLARE @SQL2 AS NVARCHAR(MAX)
    SET @SQL2='CREATE OR ALTER VIEW G10_4.uvw_Instructor_Temp2 AS

		SELECT DISTINCT 
			COALESCE(NULLIF(InstructorLastName1,'' ''), ''TBA'') AS InstructorLastName2,
			COALESCE(NULLIF(InstructorFirstName1,'' ''), ''TBA'') AS InstructorFirstName2,
			COALESCE(NULLIF(InstructorFullName1,'' ''), ''TBA'') AS InstructorFullName2,
			COALESCE(NULLIF(DepartmentName1,'' ''), ''TBA'') AS DepartmentName2
		FROM G10_4.uvw_Instructor_Temp1'
    EXEC (@SQL2)

	DECLARE @SQL3 AS NVARCHAR(MAX)
    SET @SQL3='CREATE OR ALTER VIEW G10_4.uvw_Instructor_Temp3 AS
		SELECT DISTINCT DepartmentName2, ROW_NUMBER() OVER(ORDER BY DepartmentName2) AS DepartmentKey
		FROM G10_4.uvw_Instructor_Temp2
		GROUP BY DepartmentName2'
    EXEC (@SQL3)

	DECLARE @SQL4 AS NVARCHAR(MAX)
	SET @SQL4 = 'CREATE OR ALTER VIEW G10_4.uvw_Instructor AS
		SELECT a.InstructorLastName2 as InstructorLastName, 
			a.InstructorFirstName2 as InstructorFirstName,
			a.InstructorFullName2 as InstructorFullName,
			a.DepartmentName2 as DepartmentName,
			b.DepartmentKey as DepartmentKey
		FROM G10_4.uvw_Instructor_Temp2 as a
		INNER JOIN G10_4.uvw_Instructor_Temp3 as b
		on a.DepartmentName2 = b.DepartmentName2'
	EXEC (@SQL4)

	INSERT INTO Department.Instructor (InstructorFirstName, InstructorLastName, InstructorFullName, DepartmentName, DepartmentKey, UserAuthorizationKey, DateAdded, DateOfLastUpdate) 
	SELECT InstructorFirstName, InstructorLastName, InstructorFullName, DepartmentName, DepartmentKey, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
	FROM G10_4.uvw_Instructor;

    DECLARE @EndingDateTime [Udt].[Dateof];
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount = (SELECT COUNT(*) FROM [Department].[Instructor]);
	
    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Department].[ModeOfInstruction]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Department].[Instructor];

END;
GO
/****** Object:  StoredProcedure [Project3].[Load_ModeOfInstruction]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/1/2020>
-- Description:	<Load Data Into ModeOfInstruction>
-- =============================================
CREATE PROCEDURE [Project3].[Load_ModeOfInstruction] @UserAuthorizationKey [Udt].[SurrogateKeyInt]
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
    SET @SQL='CREATE OR ALTER VIEW G10_4.uvw_ModeOfInstruction AS SELECT DISTINCT COALESCE(NULLIF([Mode of Instruction],''''), ''TBA'') AS ModeOfInstruction FROM groupnUploadfile.CoursesSpring2017;'
    EXEC (@SQL)

	INSERT INTO Course.ModeOfInstruction (ModeOfInstruction, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
	SELECT a.ModeOfInstruction, @UserAuthorizationKey, @DateAdded, @DateOfLastUpdate
	FROM G10_4.uvw_ModeOfInstruction AS a;

    DECLARE @EndingDateTime [Udt].[DateOf];
    SET @EndingDateTime = SYSDATETIME();

    DECLARE @WorkFlowStepTableRowCount INT;
    SET @WorkFlowStepTableRowCount =
    (
        SELECT COUNT(*) FROM [Course].[ModeOfInstruction]
    );

    EXEC [Process].[usp_TrackWorkFlow] 'Loads data into [Course].[ModeOfInstruction]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;
    SELECT *
    FROM [Course].[ModeOfInstruction];
END;
GO
/****** Object:  StoredProcedure [Project3].[Load_RoomLocation]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project3].[Load_RoomLocation]
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

GO
/****** Object:  StoredProcedure [Project3].[LoadData]    Script Date: 12/11/2020 2:39:53 AM ******/
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
	EXEC	[Project3].[ShowTableStatusRowCount]
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
GO
/****** Object:  StoredProcedure [Project3].[ShowTableStatusRowCount]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Project3].[ShowTableStatusRowCount] @TableStatus VARCHAR(64), @UserAuthorizationKey INT 
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
           TableName = 'Course.Class',
           [Row Count] = COUNT(*)
    FROM Course.Class
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'Course.Course',
           [Row Count] = COUNT(*)
    FROM Course.Course
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'Department.Instructor',
           [Row Count] = COUNT(*)
    FROM Department.Instructor
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'Course.ModeofInstruction',
           [Row Count] = COUNT(*)
    FROM Course.ModeOfInstruction
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'Department.Department',
           [Row Count] = COUNT(*)
    FROM Department.Department
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'Location.BuildingLocation',
           [Row Count] = COUNT(*)
    FROM [Location].BuildingLocation
    UNION ALL
    SELECT TableStatus = @TableStatus,
           TableName = 'Location.RoomLocation',
           [Row Count] = COUNT(*)
    FROM [Location].RoomLocation
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

    EXEC [Process].[usp_TrackWorkFlow] 'Procedure: [Project3].[ShowStatusRowCount]  loads data into [Project3].[ShowTableStatusRowCount]',
                                       @WorkFlowStepTableRowCount,
                                       @StartingDateTime,
                                       @EndingDateTime,
                                       @UserAuthorizationKey;


END;
GO
/****** Object:  StoredProcedure [Project3].[TruncateData]    Script Date: 12/11/2020 2:39:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/7/2020>
-- Description:	<Truncate data>
-- =============================================
CREATE PROCEDURE [Project3].[TruncateData]
	@UserAuthorizationKey int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @StartingDateTime DATETIME2 = SYSDATETIME();

	TRUNCATE TABLE Course.Class;
	TRUNCATE TABLE Course.Course;
	TRUNCATE TABLE Department.Instructor;
	TRUNCATE TABLE Course.ModeOfInstruction;
	TRUNCATE TABLE Department.Department;
	TRUNCATE TABLE [Location].BuildingLocation;
	TRUNCATE TABLE [Location].RoomLocation;
	

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
