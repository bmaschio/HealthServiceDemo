include "console.iol"
include "string_utils.iol"
include "database.iol"
include "file.iol"
include "xml_utils.iol"



main{

  scope (InstallScope){
       install (default=>     valueToPrettyString@StringUtils(InstallScope)(s);
             println@Console(s)());

      with (connectionInfo) {
        .host = "localhost";
        .driver = "sqlite"; 
        .username = "prova";
        .password = "prova";
        .database= "health_service.db"
      };
      connect@Database(connectionInfo)();
      q= "CREATE TABLE  patient_wf ( location text , service_type text , service_code text , status text , service_id text , emr_id  text)";
      update@Database(q)();
      undef (q);
      q = "CREATE TABLE patient_data ( emr_id text, name text , surname text , insurance text )";
      update@Database(q)();
      undef (q);
      q = "CREATE TABLE wf_data(service_id text , data_name text , data_value text)";
      update@Database(q)()


  }
}
