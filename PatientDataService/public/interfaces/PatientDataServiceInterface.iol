type InsuraceDataType:void{
  .insurence_id:string
  .insurence_nr:string
}

type CreatePatientAnagraficRequest:void{
   .surname:string
   .name:string
   .date_of_birth:string
   .gender:string
   .ssn:string
   .insuranceData?:InsuraceDataType
}

type CreatePatientAnagraficResponse:void{
  .mrn:long
}

type PatientPhysiologyDataType:void{
  .name:string
  .value: string
}

type AddPhysiologyDataRequest:void{
  .mrm:int
  .physiologyData*:PatientPhysiologyDataType
}

type AddPhysiologyDataResponse:void

type ModifyPatientAnagraficRequest:void{
  .surname:string
  .name:string
  .date_of_birth:string
  .gender:string
  .ssn:string
  .insuranceData?:InsuraceDataType
}

type ModifyPatientAnagraficResponse:void

type ModifyPhysiologyDataRequest:void{
  .mrm:int
  .physiologyData: PhysiologyDataType
}

type ModifyPhysiologyDataResponse:void

type RemovePhysiologyDataRequest :void{
  .mrm:int
  .physiologyData*: PhysiologyDataType
}


type RemovePhysiologyDataResponse:void


type GetPatientDataRequest:void{
  .surname:string
  .name:string
  .date_of_birth:string
  .gender:string
}

type GetPatientDataResponse:void{
  .patientData*:void{
    .surname:string
    .name:string
    .date_of_birth:string
    .gender:string
    .ssn:string
    .insuranceData?:InsuraceDataType
    .physiologyData*:PhysiologyDataType
  }
}

type GetPatientDataFromSSNRequest:void{
  .ssn:string
}

type GetPatientDataFromInsuranceRequest:void{
    .insurence_id:string
    .insurence_nr:string
}


type GetPhysiologyDataTypeRequest:void{
    .name?:string
}

type PhysiologyDataType :void{
  .name:string
  .text:string
  .type_name:string
  .type_var:string
  .referance_table?:string

}
type GetPhysiologyDataTypeResponse:void{
  .physiologyDataType*: PhysiologyDataType
}

type InsertPhysiologyDataRangeRequest:void{
  .name:string
  .min: string
  .max: string
}

type InsertPhysiologyDataRangeResponse:void


type GetPhysiologyDataRangeRequest:void{
  .name:string
}

type  GetPhysiologyDataRangeResponse:void{
  .min: string
  .max: string
}
type GetPhysiologyDataValuesRequest:void{
  .referance_table:string
}

type PhysiologyDataTableValue:void{
    .value:string
    .value_text:string
}
type GetPhysiologyDataValuesResponse:void{
    .values*: PhysiologyDataTableValue
}

type InsertPhysiologyDataTypeRequest:void{
  .name:string
  .text:string
  .type_name:string
  .type_var:string
  .referance_table?:string
}

type InsertPhysiologyDataTypeResponse:void

type CreatePhysiologyDataTableRequest:void{
  .referance_table:string
}

type CreatePhysiologyDataTableResponse:void

type InsertPhysiologyDataValueRequest:void{
  .referance_table:string
  .value:string
  .value_text:string
}
type InsertPhysiologyDataValueResponse:void

interface PatientDataServiceInterface {
RequestResponse:
  createPatientAnagrafic(CreatePatientAnagraficRequest)(CreatePatientAnagraficResponse),
  modifyPatientAnagrafic (ModifyPatientAnagraficRequest) (ModifyPatientAnagraficResponse),
  getPatientData(GetPatientDataRequest)(GetPatientDataResponse),
  getPatientDataFromSSN(GetPatientDataFromSSNRequest)(GetPatientDataResponse),
  getPatientDataFromInsurance ( GetPatientDataFromInsuranceRequest) (GetPatientDataResponse),
  addPhysiologyData (AddPhysiologyDataRequest) (AddPhysiologyDataResponse),
  removePhysiologyData (RemovePhysiologyDataRequest)(RemovePhysiologyDataResponse),
  modifyPhysiologyData (ModifyPhysiologyDataRequest)(ModifyPhysiologyDataRequest)
}

interface PatientDataServiceSupportInterface{
  RequestResponse:
   insertPhysiologyDataType (InsertPhysiologyDataTypeRequest)(InsertPhysiologyDataTypeResponse),
   getPhysiologyDataType(GetPhysiologyDataTypeRequest)(GetPhysiologyDataTypeResponse),
   insertPhysiologyDataRange (InsertPhysiologyDataRangeRequest)(InsertPhysiologyDataRangeResponse),
   getPhysiologyDataRange (GetPhysiologyDataRangeRequest) (GetPhysiologyDataRangeResponse),
   createPhysiologyDataTable(CreatePhysiologyDataTableRequest)(CreatePhysiologyDataTableResponse),
   insertPhysiologyDataValue(InsertPhysiologyDataValueRequest)(InsertPhysiologyDataValueResponse),
   getPhysiologyDataValues (GetPhysiologyDataValuesRequest) (GetPhysiologyDataValuesResponse)
}
