include "string_utils.iol"
include "console.iol"
include "database.iol"
include "file.iol"
include "../PublicResources/interfaces/PatientDataServiceInterface.iol"
include "../PublicResources/config/locations.iol"

inputPort PatientDataPort {
  Location: PatientDataServiceLocation
  Protocol: sodep
  Interfaces: PatientDataServiceInterface
}

execution{ concurrent }

init{

  with (connectionInfo) {
    .host = "localhost";
    .driver = "sqlite";
    .username = "prova";
    .password = "prova";
    .database= "health_service.db"
  };
  scope (connectionScope){
      install (default=>valueToPrettyString@StringUtils(InstallScope)(s);
          println@Console(s)());
          connect@Database(connectionInfo)()
  }
}

main{
  [addPatientWf(request)(response){
      q<< request;
      q= "insert into patient_wf (location , service_type , service_code, status , service_id , emr_id ) values (:location , :service_type , :service_code, :status , :service_id , :emr_id )";
      update@Database(q)()
    }]
  [addStepToPatientWf(request)(response){
      for (counter=0, counter < #request.data, counter++){
        q.statement[counter]= "insert into wf_data (service_id , step_id, data_name , data_value) values (:service_id , :step_id, :data_name , :data_value)";
        q.statement[counter].service_id = request.service_id;
        q.statement[counter].step_id = request.step_id;
        q.statement[counter].data_value = request.data[counter].data_value;
        q.statement[counter].data_name = request.data[counter].data_name
      };

      executeTransaction@Database(q)()
    }]
    [getStepFromPatientWf(request)(response){
        q= "select * from  wf_data where service_id = :service_id order by step_id";
        query@Database(q)(resultQ);
        for (counter = 0 , counter< #resultQ.row , counter++){
            response.step[counter].step_id = resultQ.row[counter].step_id;
            response.step[counter].data_name = resultQ.row[counter].data_name;
            response.step[counter].data_value = resultQ.row[counter].data_value
        }
      }]

}
