include "string_utils.iol"
include "console.iol"
include "../public/interfaces/PatientDataServiceInterface.iol"

outputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

main{
   request.name = "Balint";
   request.surname = "Maschio";
   request.ssn = "AAAADDEFDSADA";
   request.date_of_birth = "22/10/1977";
   request.gender = "MALE";
   createPatientAnagrafic@PatientDataPort(request)(response);
   valueToPrettyString@StringUtils(response)(s);
   println@Console(s)()
}
