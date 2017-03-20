include "../../PublicResources/interfaces/PatientDataServiceInterface.iol"
include "../../PublicResources/config/locations.iol"

outputPort PatientDataPort {
  Location: PatientDataServiceLocation
  Protocol: sodep
  Interfaces: PatientDataServiceInterface
}

main{
  with (requestAddPatientWf){
    .location = "10001";
    .service_type = "GenericPatient";
    .service_code = "check_up_wf";
    .status=  "running";
    .service_id = "dsadsadfasfcnds";
    .emr_id = "aaaaabbbbb"
  };
  addPatientWf@PatientDataPort(requestAddPatientWf)(responseAddPatientWf)
}
