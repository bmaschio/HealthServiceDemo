include "../public/interfaces/PatientDataServiceInterface.iol"

outputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

main{
  request.mrn = 5;
  request.physiologyData[0].value = "A";
  request.physiologyData[0].name = "blood_type";
  request.physiologyData[1].value = "150";
  request.physiologyData[1].name = "blood_pressure";
  addPhysiologyData@PatientDataPort(request)(response)
}
