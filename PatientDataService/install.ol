include "../public/interfaces/InstallationInterface.iol"
include "console.iol"
include "string_utils.iol"
include "database.iol"

inputPort InstallationPort {
  Location: "socket://localhost:4000"
  Protocol: sodep
  Interfaces: InstallationInterface
}
execution{ concurrent }
main{
[setConfigFile(request)(response){
    for (counter= 0, counter < #request.configData, counter++ ){
      requestData.data.(request.configData[counter].name) = request.configData[counter].value
    };
    valueToPrettyString@StringUtils(requestData)(s);
    println@Console(s)()

  }]
  [runInstall(request)(response){
      with (connectionInfo) {
        .host="localhost";
        .port= 5432;
        .driver = "postgresql";
        .database= "postgres";
        .username="postgres";
        .password= "postgres"
      };
      connect@Database(request)();
      q = "CREATE DATABASE 'PatientData' WITH OWNER = postgres ENCODING = 'UTF8'";
      query@Database(q)();
      close@Database()();

      with (connectionInfo) {
        .host="localhost";
        .port= 5432;
        .driver = "postgresql";
        .database= "PatientData";
        .username="postgres";
        .password= "postgres"
      };
      connect@Database(request)();

      




    }]

}
