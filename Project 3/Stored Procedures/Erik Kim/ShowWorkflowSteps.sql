/****** Object:  StoredProcedure [Process].[usp_ShowWorkflowSteps]    Script Date: 12/8/2020 8:55:51 PM ******/
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

