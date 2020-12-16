USE QueensClassScheduleSpring2017;

DROP TABLE IF EXISTS [Course].[Class]
CREATE TABLE [Course].[Class]
(
	[ClassKey] [Udt].[SurrogateKeyInt] PRIMARY KEY IDENTITY(1,1) NOT NULL,
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
    [ModeOfInstruction] [Udt].[ModeOfInstruction] NOT NULL DEFAULT 'TBA',
    [UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
    [DateAdded] [Udt].[DateOf] NULL DEFAULT SYSDATETIME(),
    [DateOfLastUpdate] [Udt].[DateOf] NOT NULL DEFAULT SYSDATETIME()
);
