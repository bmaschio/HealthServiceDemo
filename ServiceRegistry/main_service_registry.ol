include"./public/interfaces/ServiceRegistryInterface.iol"
include "console.iol"
include "string_utils.iol"

include "../locations.iol"

execution{ concurrent }

inputPort ServiceRegistryPort {
Location: ServiceRegistryLocation
Protocol: sodep
Interfaces: ServiceRegistryInterface
}

init {
   start_port = 10000;
   println@Console("ServiceRegister Started")()
}

main{
 [addService(request)(response){
      getRandomUUID@StringUtils()(randomKeyResponse);
      global.services.(request.service.serviceCategory).(randomKeyResponse).location = request.service.location;
      response.uniqueId = randomKeyResponse;
      valueToPrettyString@StringUtils(global)(s);
      println@Console(s)()
   }]

 [ getNextLocation( request )( response ) {
      response.host = "localhost";
      response.port = start_port++
 }]

 [removeService(request)(response){
     undef (global.services.(request.serviceCategory).(request.uniqueId))
   }]
 [searchService(request)(response){
     counter = 0;
     foreach (uniqueId : global.services.(request.serviceCategory)){
         response.service[counter].uniqueId = uniqueId;
         response.service[counter].location = global.services.(request.serviceCategory).(uniqueId).location;
         counter++
     }
   }]

}
