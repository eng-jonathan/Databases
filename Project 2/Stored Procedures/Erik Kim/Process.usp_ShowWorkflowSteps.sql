USE [BIClass]
GO
/****** Object:  StoredProcedure [Process].[usp_ShowWorkflowSteps]    Script Date: 11/17/2020 6:45:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erik Kim
-- Create date: 11/17/2020
-- Description:	Show workflow steps
-- =============================================
ALTER PROCEDURE [Process].[usp_ShowWorkflowSteps] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT *
	FROM [Process].[WorkFlowSteps];
END
