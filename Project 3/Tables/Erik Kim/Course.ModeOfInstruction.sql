CREATE TABLE [Course].[ModeofInstruction]
(
    [ModeOfInstructionKey] [Udt].[SurrogateKeyInt] NOT NULL IDENTITY PRIMARY KEY,
    [ModeOfInstruction] [Udt].[ModeOfInstruction] NOT NULL,
    [UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
    [DateAdded] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME(),
    [DateOfLastUpdate] [Udt].[DateOf] NULL
        DEFAULT SYSDATETIME()
);