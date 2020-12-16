/*Table Creation*/
CREATE TABLE [Department].[Instructor]
(
	[InstructorKey] [Udt].[SurrogateKeyInt] NOT NULL IDENTITY PRIMARY KEY, 
	[InstructorFirstName] [Udt].[Name] NULL,
	[InstructorLastName] [Udt].[Name] NULL,
	[InstructorFullName] [Udt].[Name] NULL,
	[DepartmentName] [Udt].[DepartmentName] NULL,
	[DepartmentKey] [Udt].[SurrogateKeyInt] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
    [DateAdded] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME(),
    [DateOfLastUpdate] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME()
);

/*END OF TABLE CREATION*/