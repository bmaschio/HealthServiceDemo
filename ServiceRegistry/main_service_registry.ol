include"./public/interfaces/ServiceRegistryInterface.iol"
include "console.iol"
include "string_utils.iol"

execution{ concurrent }
init {
   println@Console("ServiceRegister Started")()
}
inputPort ServiceRegistryPort {
Location: "socket://localhost:2000"
Protocol: sodep
Interfaces: ServiceRegistryInterface
}
main{
 [addService(request)(response){
      getRandomUUID@StringUtils()(randomKeyResponse);
      global.services.(request.service.serviceCategory).(randomKeyResponse).location = request.service.location;
      response.uniqueId = randomKeyResponse;
      valueToPrettyString@StringUtils(global)(s);
      println@Console(s)()
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
