include"../public/interfaces/ServiceRegistryInterface.iol"
include "console.iol"
include "string_utils.iol"


outputPort ServiceRegistryPort {
Location: "socket://localhost:2000"
Protocol: sodep
Interfaces: ServiceRegistryInterface
}

main{
  for (counter = 0 , counter< 10,counter++ ){
    with (requestAddService.service){
          .serviceCategory = "NURSE";
          .location ="socket://localhost:300" + counter
        } ;
    addService@ServiceRegistryPort(requestAddService)(responseAddService);
    valueToPrettyString@StringUtils(responseAddService)(s);
    println@Console(s)()
}
}
