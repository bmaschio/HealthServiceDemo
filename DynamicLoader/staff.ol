include "console.iol"
include "ini_utils.iol"
include "../DynamicLoader/ActivityInterface.iol"
include "../StaffService/public/interfaces/GeneralStaffInterface.iol"
include"../ServiceRegistry/public/interfaces/ServiceRegistryInterface.iol"

include "../locations.iol"

execution{ concurrent }

inputPort Staff {
  Location: "local"
  Protocol: sodep
  Interfaces: GeneralStaffInterface, ActivityInterface
}

outputPort ServiceRegistryPort {
  Location: ServiceRegistryLocation
  Protocol: sodep
  Interfaces: ServiceRegistryInterface
}

inputPort StaffExt {
  Location: "socket://localhost:7000"
  Protocol: sodep
  Interfaces: GeneralStaffInterface, ActivityInterface
}

init{
  global.status= "Waiting"
}

main{
  [ run( request )( response ) {
       println@Console("Staff is running..." )();
       if ( global.status== "Waiting" ){
         with (requestAddService.service){
               .serviceCategory = "DOCTOR";
               .location ="socket://localhost:7000"
             } ;
         addService@ServiceRegistryPort(requestAddService)(responseAddService);
         response.stop = false;
         global.status= "Running"

       };

       if ( global.status== "Running" ){
          response.stop = false

       };

       if ( global.status== "Stoping" ){
          response.stop = true

       }

    }]

    [stop(request)(response){
        /* here deallocate resorses*/
        global.status= "Stoping"

    }]

    [ addVisit(request)(response){
       indexLastVisit = #global.schedule.visit;
       println@Console(indexLastVisit)();
       global.schedule.visit[indexLastVisit].patientId = request.patientId;
       global.schedule.visit[indexLastVisit].patientLoc = request.patientLoc;
       global.schedule.visit[indexLastVisit].time = request.time
    }]

    [ getVisit(request)(response){
        response << global.schedule
    }]
}
