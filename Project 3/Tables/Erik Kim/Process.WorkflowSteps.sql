CREATE TABLE [Process].[WorkflowSteps]
(
	[WorkFlowStepKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[WorkFlowStepDescription] [Udt].[Description] NOT NULL,
	[WorkFlowStepTableRowCount] [Udt].[Count] NULL,
	[StartingDateTime] [Udt].[DateOf] NULL,
	[EndingDateTime] [Udt].[DateOf] NULL,
	[Class Time] [Udt].[ClassTime] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL
)