include "../PublicResources/interfaces/GeneralStaffInterface.iol"
include "../PublicResources/interfaces/PatientWfInterface.iol"
include "../PublicResources/interfaces/ActivityInterface.iol"

include"../ServiceRegistry/public/interfaces/ServiceRegistryInterface.iol"
include "../PublicResources/config/locations.iol"
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

outputPort ServiceRegistryPort {
  Location: ServiceRegistryLocation
  Protocol: sodep
  Interfaces: ServiceRegistryInterface
}
execution{single}

main{

   println@Console ("Doing Something for Step1")();
   init_service(request)(response){
     /* here it will register itself to the ServiceRegistry*/
     with (requestAddService.service){
           .serviceCategory = request.service_type ;
           .location = global.inputPorts.StaffExt.location
         } ;
     addService@ServiceRegistryPort(requestAddService)(responseAddService);
     global.wf_status.patient_data << request.patient_data
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
        response << global.wf_status
    }]

    until

    [setStepData(request)(response){
      println@Console ("Closing Step1")()
    }]

  }
