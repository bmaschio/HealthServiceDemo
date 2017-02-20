include "console.iol"
include "ini_utils.iol"
include "/public/interfaces/GeneralStaffInterface.iol"
include"../ServiceRegistry/public/interfaces/ServiceRegistryInterface.iol"

execution{ concurrent }

inputPort Staff {
  Location: "local"
  Protocol: sodep
  Interfaces: GeneralStaffInterface
}

inputPort StaffExt {
  Location: "socket://localhost:7000"
  Protocol: sodep
  Interfaces: GeneralStaffInterface
}


outputPort ServiceRegistryPort {
Location: "socket://localhost:2000"
Protocol: sodep
Interfaces: ServiceRegistryInterface
}

init{
  global.status= "Waiting"
}
main{
  [run(request)(response){
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
    [addVisit(request)(response){
       indexLastVisit = #global.schedule.visit;
       println@Console(indexLastVisit)();
       global.schedule.visit[indexLastVisit].patientId = request.patientId;
       global.schedule.visit[indexLastVisit].patientLoc = request.patientLoc;
       global.schedule.visit[indexLastVisit].time = request.time
      }]
    [getVisit(request)(response){
        response << global.schedule
      }]
}
