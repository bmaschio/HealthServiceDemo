type CreatePatientAnagraficRequest:void{
   .surname:string
   .name:string
   .dateOfBirth:string
   .gender:string
   .ssn:string
   .insuranceData?:void{
     .insurence_id:string
     .insurence_nr:string
   }
}

type CreatePatientAnagraficResponse:void{
  .mrn:int
}

type AddPhysiologyDataRequest:void{
  .mrm:int
  .physiologyData:void{
    .name:string
    .value: string
  }
}

type AddPhysiologyDataResponse:void

type ModifyPatientAnagraficRequest:void{
  .surname:string
  .name:string
  .dateOfBirth:string
  .gender:string
  .ssn:string
  .insuranceData?:void{
    .insurence_id:string
    .insurence_nr:string
  }
}

type ModifyPatientAnagraficResponse:void

type ModifyPhysiologyDataRequest:void{
  .mrm:int
  .physiologyData:void{
    .name:string
    .value: string
  }
}

type ModifyPhysiologyDataResponse:void

type RemovePhysiologyDataRequest :void{
  .mrm:int
  .physiologyData*:void{
    .name:string
    .value: string
  }
}


type RemovePhysiologyDataResponse:void


type GetPatientDataRequest:void{
  .surname:string
  .name:string
  .dateOfBirth:string
  .gender:string
}

type GetPatientDataResponse:void{
  .patientData*:void{
    .surname:string
    .name:string
    .dateOfBirth:string
    .gender:string
    .ssn:string
    .insuranceData?:void{
      .insurence_id:string
      .insurence_nr:string
    }
    .physiologyData*:void{
      .name:string
      .value: string
    }
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
  .physiologyDataType:void{
      .name:string
      .type:string
      .dataTable?:string
  }
}
type GetPhysiologyDataRangeRequest:void{
      .name:string
}

type  GetPhysiologyDataRangeResponse:void{
  .min: any
  .max: any
  .type: string
}
type GetPhysiologyDataValuesRequest:void{
  .dataTable:string
}

type GetPhysiologyDataValuesRequest:void{
   .values*:string
}
interface PatientDataServiceInterface {
RequestResponse:
  createPatientAnagrafic(CreatePatientAnagraficRequest)(CreatePatientAnagraficResponse),
  modifyPatientAnagrafic (ModifyPatientAnagraficRequest) (ModifyPatientAnagraficResponse),
  getPatientData(GetPatientDataRequest)(GetPatientDataResponse),
  getPatientDataFromSSN(GetPatientDataFromSSNRequest)(GetPatientDataResponse),
  getPatientDataFromInsurance ( GetPatientDataFromInsuranceRequest) (GetPatientDataFromInsuranceResponse),
  addPhysiologyData (AddPhysiologyDataRequest) (AddPhysiologyDataResponse),
  removePhysiologyData (RemovePhysiologyDataRequest)(RemovePhysiologyDataResponse),
  modifyPhysiologyData (ModifyPhysiologyDataRequest)(ModifyPhysiologyDataRequest)
}

interface PatientDataServiceSupportInterface{
  RequestResponse:
   getPhysiologyDataType(GetPhysiologyDataTypeRequest)(GetPhysiologyDataTypeResponse),
   getPhysiologyDataRange (GetPhysiologyDataRangeRequest) (GetPhysiologyDataRangeResponse),
   getPhysiologyDataValues (GetPhysiologyDataValuesRequest) (GetPhysiologyDataValuesResponse)
}
