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
    scope (createPatientAnagraficScope){
      install (default=> valueToPrettyString@StringUtils(createPatientAnagraficScope)(s);
            println@Console(s)());
            if (is_defined(request.insuranceData.insurence_id)){
                 q.statement[0] ="insert into patient_data( surname, name, date_of_birth, gender, ssn, insurence_id, insurance_nr ) values( :surname, :name, to_date(:date_of_birth, 'dd/MM/yyyy'), :gender, :ssn ,:insurence_id, :insurance_nr)";
                 q.statement[0].name = request.name;
                 q.statement[0].surname = request.surname;
                 q.statement[0].date_of_birth = request.date_of_birth;
                 q.statement[0].gender = request.gender;
                 q.statement[0].ssn = request.ssn;
                 q.statement[0].insurance_nr = request.insuranceData.insurance_nr;
                 q.statement[0].insurance_id = request.insuranceData.insurance_id
            }else{
                 q.statement[0] ="insert into patient_data( surname, name, date_of_birth, gender, ssn ) values( :surname, :name, to_date(:date_of_birth, 'dd/MM/yyyy'), :gender, :ssn )";
                 q.statement[0].name = request.name;
                 q.statement[0].surname = request.surname;
                 q.statement[0].date_of_birth = request.date_of_birth;
                 q.statement[0].gender = request.gender;
                 q.statement[0].ssn = request.ssn
            };
                q.statement[1] = "select currval('mrn_sequence') as cur_val";
                executeTransaction@Database(q)(resultQ);
                valueToPrettyString@StringUtils(resultQ)(s);
                println@Console(s)();
                response.mrn = resultQ.result[1].row.cur_val
            }
    }]

  [modifyPatientAnagrafic(request)(response){
    scope (addPhysiologyDataScope){
      install (default=> valueToPrettyString@StringUtils(addPhysiologyDataScope)(s);
            println@Console(s)());
        for (counter =0 , counter < #request.physiologyData, counter++){
             q.statement[counter]= "update into physiology_data(mrn_key, name,value) VALUES (:mrn_key, :name, :value) ";
             q.statement[counter].name = request.physiologyData[counter].name;
             q.statement[counter].value = request.physiologyData[counter].value;
             q.statement[counter].mrm_key =request.mrn
           };
          executeTransaction@Database(q)(resultQ)
      }
    }]

  [addPhysiologyData(request)(response){
    scope (addPhysiologyDataScope){
      install (default=> valueToPrettyString@StringUtils(addPhysiologyDataScope)(s);
            println@Console(s)());
        for (counter =0 , counter < #request.physiologyData, counter++){
             q.statement[counter]= "insert into physiology_data(mrn_key, name, value) VALUES (:mrn_key, :name, :value) ";
             q.statement[counter].name = request.physiologyData[counter].name;
             q.statement[counter].value = request.physiologyData[counter].value;
             q.statement[counter].mrm_key =request.mrn
           };
          executeTransaction@Database(q)(resultQ)
      }
    }]

  [modifyPhysiologyData(request)(response){
    scope (modifyPhysiologyDataScope){
      install (default=> valueToPrettyString@StringUtils(modifyPhysiologyDataScope)(s);
            println@Console(s)());
        for (counter =0 , counter < #request.physiologyData, counter++){
             q.statement[counter]= "update physiology_data set value = :value where mrn_key = :mrm_key  and name=:name";
             q.statement[counter].name = request.physiologyData[counter].name;
             q.statement[counter].value = request.physiologyData[counter].value;
             q.statement[counter].mrm_key =request.mrn
           };
          executeTransaction@Database(q)(resultQ)
      }
    }]

  [removePhysiologyData(request)(response){
    scope (removePhysiologyDataScope){
      install (default=> valueToPrettyString@StringUtils(removePhysiologyDataScope)(s);
            println@Console(s)());
        for (counter =0 , counter < #request.physiologyData, counter++){
             q.statement[counter]= "delete from  physiology_data  where mrm = :mrm_key and name=:name";
             q.statement[counter].name = request.physiologyData[counter].name;
             q.statement[counter].mrm_key =request.mrn
           };
          executeTransaction@Database(q)(resultQ)
      }
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
             )";
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
    [getPatientData(request)(response){
      scope (getPatientDataScope){
        install (default=> valueToPrettyString@StringUtils(getPatientDataScopes)(s);
                           println@Console(s)());
          q= "select * from patient_data";
          if (is_defined(request.surname)) {
            q = " where surname like :surname_search";
            q.surname_search = request.surname
          };
          if (is_defined(request.name)){
            q+= " where name like :name_search";
            q.name_search = request.name
          };
          if (is_defined(request.ssn)){
            q+= " where ssn = :ssn";
            q.ssn = request.ssn
          };

          if (is_defined(request.insurance_id) && is_defined( request.insurace_id )){
            q+= " where insurance_id like :insurance_id and insurance_nr like insurance_nr";
            q.insurance_id = request.insurance_id;
            q.insurance_nr = request.insurance_nr
          };

          valueToPrettyString@StringUtils(q)(s);
          println@Console(s)();
          query@Database(q)(response_q);
          valueToPrettyString@StringUtils(response_q)(s);
          println@Console(s)();
          for (counter = 0 , counter < #response_q.row ,counter++){
            with (response.patientData[counter]){
                .name = response_q.row[counter].name;
                .surname = response_q.row[counter].surname;
                .date_of_birth = response_q.row[counter].date_of_birth;
                .gender = response_q.row[counter].gender;
                .ssn = response_q.row[counter].ssn;
                if (response_q.row[counter].insurence_id != ""){
                   .insuranceData.insurance_id = response_q.row[counter].insurance_id;
                   .insuranceData.insurance_nr = response_q.row[counter].insurance_nr
                }
            }
          }


       }
      }]
}
