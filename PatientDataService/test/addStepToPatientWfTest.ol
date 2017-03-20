include "../../PublicResources/interfaces/PatientDataServiceInterface.iol"
include "../../PublicResources/config/locations.iol"

outputPort PatientDataPort {
  Location: PatientDataServiceLocation
  Protocol: sodep
  Interfaces: PatientDataServiceInterface
}

main{
  with (requestAddStepToPatientWf){
    .service_id = "dsadsadfasfcnds";
    .step_id = "first_step";
    .data[0].data_name ="blood_type";
    .data[0].data_value = "O-";
    .data[1].data_name ="blood_pressure_min";
    .data[1].data_value = "80"

  };
  addStepToPatientWf@PatientDataPort(requestAddStepToPatientWf)(responseAddStepToPatientWf)
}
