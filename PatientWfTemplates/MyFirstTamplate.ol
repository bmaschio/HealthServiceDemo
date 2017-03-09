include "../PublicResources/interfaces/GeneralStaffInterface.iol"
include "../PublicResources/interfaces/PatientWfInterface.iol"
include "../PublicResources/interfaces/ActivityInterface.iol"
include "console.iol"

inputPort PatientPort {
  Location: "local"
  Protocol: sodep
  Interfaces: PatientWfInterface, ActivityInterface
}


inputPort PatientPortExt {
  Location: "localExt"
  Protocol: sodep
  Interfaces: PatientWfInterface, ActivityInterface
}
execution{single}

main{

   println@Console ("Doing Something for Step1")();
   init_service(request)(response){
     /* here it will register itself to the ServiceRegistry*/
     println@Console ("Service Started")()
   };
   provide
     [getStepMetaData()(){
        /* here will provide some meta data that will be presented on WEB application*/
        nullProcess
      }]
    [stop_service()(){
          /*Killing the service*/
          exit
        }]

    [getPatientWfStatus(request)(response){
        println@Console ("Waiting for step 1")()
    }]

    until

    [setStepData(request)(response){
      println@Console ("Closing Step1")()
    }]

  }
