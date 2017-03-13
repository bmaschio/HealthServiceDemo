type AddPatientWfRequest: void {
  .location:string
  .service_type:string
  .service_code:string
  .status:string
  .service_id:string
  emr_id :string
}
type AddPatientWfResponse: void

type AddStepToPatientWfRequest:void {
  .service_id:string
  .step_id:int
  .data*:void{
    .name:string
    .value:string
  }
}

type AddStepToPatientWfResponse:void

type GetStepFromPatientWfRequest:void{
   .service_id:string
}

type GetStepFromPatientWfResponse:void{
  .step*:void{
    .step_id:int
    .data*:void{
      .name:string
      .value:string
    }
  }
}

interface interfaceName {
RequestResponse:
   addPatientWf(AddPatientWfRequest)(AddPatientWfResponse),
   addStepToPatientWf (AddStepToPatientWfRequest)(AddStepToPatientWfResponse),
   getStepFromPatientWf (GetStepFromPatientWfRequest)(GetStepFromPatientWfResponse)
}
