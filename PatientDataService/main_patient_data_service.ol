include "string_utils.iol"
include "console.iol"
include "database.iol"
include "file.iol"
include "./public/interfaces/PatientDataServiceInterface.iol"

inputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

execution{ concurrent }

init{

  with (requestReadFile) {
         .filename = "config.xml";
         .format="xml"
   };

   readFile@File(requestReadFile)(config);

  with (connectionInfo) {
    .host=config.configData.location;
    .port= int (config.configData.port);
    .driver = config.configData.driver;
    .database= "patient_data";
    .username=config.configData.username;
    .password= config.configData.password
  };
  scope (connectionScope){
      install (default=>valueToPrettyString@StringUtils(InstallScope)(s);
          println@Console(s)());
      connect@Database(connectionInfo)()
  }
}

main{

  [createPatientAnagrafic(request)(response){
        nullProcess
    }]

  [modifyPatientAnagrafic(request)(response){
          nullProcess
    }]

  [addPhysiologyData(request)(response){
          nullProcess

    }]

  [modifyPhysiologyData(request)(response){

        nullProcess
    }]

  [removePhysiologyData(request)(response){
       nullProcess
    }]
  [getPhysiologyDataType(request)(response){
      scope (getPhysiologyDataTypeScope){
        install (default=> valueToPrettyString@StringUtils(getPhysiologyDataTypeScope)(s);
              println@Console(s)());
        if (is_defined (request.name)){
          q<< request;
          q = "select * from physiology_data_type where name = :name"

        }else{
          q= "select * from physiology_data_type"
        };
        query@Database(q)(resultQ);
        valueToPrettyString@StringUtils(resultQ)(s);
        println@Console(s)();
        for (counter = 0 , counter< #resultQ.row , counter++){
          with (response.physiologyDataType[counter]){
             .name =resultQ.row[counter].name;
             .text = resultQ.row[counter].text;
             .type_name = resultQ.row[counter].type_name;
             .type_var  = resultQ.row[counter].type_var;
             if (resultQ.row[counter].referance_table!=""){
                .referance_table = resultQ.row[counter].referance_table
              }
          }
        };
        valueToPrettyString@StringUtils(response)(s);
        println@Console(s)()

      }
    }]

    [insertPhysiologyDataType(request)(response){
      scope (insertPhysiologyDataTypeScope){
        install (default=> valueToPrettyString@StringUtils(insertPhysiologyDataTypeScope)(s);
                 println@Console(s)());
          if (is_defined(request.referance_table)){
            q<< request;
            q= "insert into physiology_data_type values(:name , :text, :type_name  , :type_var , :referance_table)"
          } else{
            q= "insert into physiology_data_type(name , text , type_name  , type_var ) values (:name , :text, :type_name  , :type_var )";
            q.name = request.name;
            q.text = request.text;
            q.type_name = request.type_name;
            q.type_var = request.type_var
          };
          update@Database(q)()
      }
      }]
[insertPhysiologyDataRange(request)(response){
  scope (insertPhysiologyDataRangeScope){
    install (default=> valueToPrettyString@StringUtils(insertPhysiologyDataRangeScope)(s);
             println@Console(s)());
      q<<request;
      q ="insert into physiology_data_range values (:name, :min ,:max)";
      update@Database(q)()
    }
  }]
  [getPhysiologyDataRange(request)(response){
    scope (getPhysiologyDataRangeScope){
      install (default=> valueToPrettyString@StringUtils(getPhysiologyDataRangeScope)(s);
               println@Console(s)());
          q << request;
          q = "select * from physiology_data_range where name=:name";
          query@Database(q)(resultQ);
          response.min = resultQ.row.min;
          response.max = resultQ.row.max
        }
    }]
[createPhysiologyDataTable(request)(response){
  scope (createPhysiologyDataTableScope){
    install (default=>         valueToPrettyString@StringUtils(createPhysiologyDataTableScope)(s);
             println@Console(s)());
    q= "CREATE TABLE public." + request.referance_table +
       " (
             value character varying ,
             value_text character varying
           )
           WITH (
             OIDS = FALSE
             )";{
      update@Database(q)()
    }
  }]
  [insertPhysiologyDataValue(request)(response){
    scope (createPhysiologyDataTableScope){
      install (default=>         valueToPrettyString@StringUtils(createPhysiologyDataTableScope)(s);
               println@Console(s)());
          q = "insert into " + request.referance_table + " values (:value , :value_text)";
          q.value = request.value;
          q.value_text = request.value_text;
          update@Database(request)()
      }
    }]
}
