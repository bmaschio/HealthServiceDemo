include "string_utils.iol"
include "console.iol"
include "../public/interfaces/PatientDataServiceInterface.iol"

outputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

main{
  request.referance_table = "blood_type_table";
  createPhysiologyDataTable@PatientDataPort(request)()
}
