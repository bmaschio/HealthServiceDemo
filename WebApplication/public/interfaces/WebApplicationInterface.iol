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

type AddPatientResponse:void{
  .mrn: string
  .status: string
}

type  PhysiologyType : void{
  .name:string
  .value: string
}

type  PhysiologyErrorType : void{
  .name:string
  .value: string
}
type AddPatientPhysiologyRequest:void{
  .mrm:int
  .physiologyData*: PhysiologyType
}
type AddPatientPhysiologyResponse :void{
  .status: string
  .error*: PhysiologyErrorType
}


interface WebApplicationInterface {
RequestResponse:
  addPatient(AddPatientRequest)(AddPatientResponse),
  addPatientPhysiology(AddPatientPhysiologyRequest)(AddPatientPhysiologyResponse)
}
