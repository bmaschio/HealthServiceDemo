include "string_utils.iol"
include "console.iol"
include "database.iol"
include "./public/interfaces/PatientDataServiceInterface.iol"

inputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataInterface
}

main{

  [createPatientAnagrafic(request)(response){
     
    }]

  [modifyPatientAnagrafic(request)(response){

    }]

  [addPhysiologyData(request)(response){


    }]

  [modifyPhysiologyData(request)(response)]{


    }]
  [removePhysiologyData(request)(response){

    }]

}
