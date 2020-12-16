CREATE TABLE [Department].[Department]
(
    [DepartmentKey] [Udt].[SurrogateKeyInt] NOT NULL IDENTITY PRIMARY KEY,
    [DepartmentName] [Udt].[DepartmentName] NOT NULL,
    [UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
    [DateAdded] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME(),
    [DateOfLastUpdate] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME()
);