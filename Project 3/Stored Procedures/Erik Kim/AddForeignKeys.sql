/****** Object:  StoredProcedure [Project3].[AddForeignKeys]    Script Date: 12/8/2020 8:55:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Erik Kim>
-- Create date: <12/7/2020>
-- Description:	<Add Foreign Keys>
-- =============================================
ALTER PROCEDURE [Project3].[AddForeignKeys] @UserAuthorizationKey INT
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