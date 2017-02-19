include"../public/interfaces/ServiceRegistryInterface.iol"
include "console.iol"
include "string_utils.iol"


outputPort ServiceRegistryPort {
Location: "socket://localhost:2000"
Protocol: sodep
Interfaces: ServiceRegistryInterface
}

main{
   with (requestSearchService){
     .serviceCategory = "NURSE"
   } ;
  searchService@ServiceRegistryPort(requestSearchService)(responseSearchService);
  valueToPrettyString@StringUtils(responseSearchService)(s);
  println@Console(s)()
}
