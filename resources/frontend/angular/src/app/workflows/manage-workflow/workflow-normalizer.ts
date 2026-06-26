import { Workflow } from '@core/domain-classes/workflow';
import { WorkflowStep } from '@core/domain-classes/workflow-step';
import { WorkflowTransition } from '@core/domain-classes/workflow-transition';

type RawWorkflow = Workflow & {
  workflowsteps?: WorkflowStep[];
};

export function normalizeWorkflow(workflow?: Workflow | null): Workflow | null {
  if (!workflow) {
    return null;
  }

  const raw = workflow as RawWorkflow;

  return {
    ...workflow,
    workflowSteps: raw.workflowSteps ?? raw.workflowsteps ?? [],
    transitions: raw.transitions ?? [],
  };
}

export function normalizeWorkflows(workflows: Workflow[] = []): Workflow[] {
  return workflows.map((workflow) => normalizeWorkflow(workflow) as Workflow);
}

export function getWorkflowSteps(workflow?: Workflow | null): WorkflowStep[] {
  return normalizeWorkflow(workflow)?.workflowSteps ?? [];
}

export function getWorkflowTransitions(workflow?: Workflow | null): WorkflowTransition[] {
  return normalizeWorkflow(workflow)?.transitions ?? [];
}
