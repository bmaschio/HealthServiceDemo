include "string_utils.iol"
include "console.iol"
include "../public/interfaces/PatientDataServiceInterface.iol"

outputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

main{
   request.name = "Bal%";
   getPatientData@PatientDataPort(request)(response);
   valueToPrettyString@StringUtils(response)(s);
   println@Console(s)()
}
