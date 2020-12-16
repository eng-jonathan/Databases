CREATE TABLE [Course].[Course]
(
	[CourseKey] [Udt].[SurrogateKeyInt] NOT NULL IDENTITY PRIMARY KEY, 
	[CourseName][udt].[CourseName] NULL,
	[CourseDescription] [Udt].[CourseDesc] NULL,
    [UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
    [DateAdded] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME(),
    [DateOfLastUpdate] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME()
);