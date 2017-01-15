

type CreatePlanRequest:void{
   .mrn:int
   .doctor: string
   .date:string
}

type CreatePlanResponse:void{
  .patientId:int
}



interface PlannerInterface {
  RequestResponse:
    createPlan(CreatePlanRequest)(CreatePlanResponse),
    deletePlan(DeletePlanRequest)(DeletePlanResponse)
    processPlan(ProcessPlanRequest)(ProcessPlanResponse),
    addStepToPlan (AddStepToPlanRequest)(AddStepToPlanResponse),
    removeStepFromPlan (RemoveStepFromPlanRequest)(RemoveStepFromPlanResponse),
    closeStepFromPlan (CloseStepFromPlanRequest)(CloseStepFromPlanResponse)
}
