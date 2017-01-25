type insuranceType:void{
  .insurence_id:string
  .insurence_nr:string
}

type AddPatientRequest:void{
  .surname:string
  .name:string
  .date_of_birth:string
  .gender:string
  .ssn:string
  .insuranceData?:insuranceType
}




interface WebApplicationInterface {
RequestResponse:
  addPatient(AddPatientRequest)(AddPatientResponse),
  addPatientPhysiology(AddPatientPhysiologyRequest)(AddPatientPhysiologyResponse)
}
