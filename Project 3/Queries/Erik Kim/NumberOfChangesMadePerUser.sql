SELECT DISTINCT
       UserAuthorizationKey,
       COUNT(WorkFlowStepDescription) AS NumberOfChanges
FROM Process.WorkflowSteps
GROUP BY UserAuthorizationKey;