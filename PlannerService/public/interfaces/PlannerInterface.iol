

type CreatePlanRequest:void{
   .mrn:int
   .doctor: string
   .date:string
}

type CreatePlanResponse:void{
  .plan_id:int
}

type DeletePlanRequest:void{
  .planId:int
}
type DeletePlanResponse:void

type ProcessPlanRequest:void{
  .plan_id:int
}

type  ProcessPlanResponse:void

type StepDataType:void{
  .name: string
  .value: string
}

type AddStepToPlanRequest:void{
  .plan_id: string
  .function: string
  .data*:StepDataType
  .prerequisit*:string
}

type AddStepToPlanResponse: void{
  .step_id: string
}

type RemoveStepFromPlanRequest: void{
  .step_id: string
}

type RemoveStepFromPlanResponse: void

type CloseStepFromPlanRequest:void{
  .step_id:string
}

type CloseStepFromPlanResponse: void 

interface PlannerInterface {
  RequestResponse:
    createPlan(CreatePlanRequest)(CreatePlanResponse),
    deletePlan(DeletePlanRequest)(DeletePlanResponse),
    processPlan(ProcessPlanRequest)(ProcessPlanResponse),
    addStepToPlan (AddStepToPlanRequest)(AddStepToPlanResponse),
    removeStepFromPlan (RemoveStepFromPlanRequest)(RemoveStepFromPlanResponse),
    closeStepFromPlan (CloseStepFromPlanRequest)(CloseStepFromPlanResponse)
}
