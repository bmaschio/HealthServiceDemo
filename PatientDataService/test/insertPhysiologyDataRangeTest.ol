include "string_utils.iol"
include "console.iol"
include "../public/interfaces/PatientDataServiceInterface.iol"

outputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

main{
  request.name = "blood_pressure";
  request.min  = "50.0";
  request.max  = "250.0";
  insertPhysiologyDataRange@PatientDataPort(request)(response)
}
