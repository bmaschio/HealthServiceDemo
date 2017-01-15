include "../public/interfaces/PatientDataServiceInterface.iol"

outputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

main{
  request.referance_table = "blood_type_table";
  request.value = "A";
  request.value_text = "A";
  insertPhysiologyDataValue@PatientPort(request)(response)
}
