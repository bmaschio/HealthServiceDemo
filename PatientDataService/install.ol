include "console.iol"
include "string_utils.iol"
include "database.iol"
include "file.iol"
include "xml_utils.iol"



main{

  scope (InstallScope){
       install (default=>     valueToPrettyString@StringUtils(InstallScope)(s);
             println@Console(s)());

     with (requestReadFile) {
            .filename = "config.xml";
            .format="xml"
      };
      readFile@File(requestReadFile)(config);
      with (connectionInfo) {
        .host=config.configData.location;
        .port= int (config.configData.port);
        .driver = config.configData.driver;
        .database= config.configData.startingdb;
        .username=config.configData.username;
        .password= config.configData.password
      };


      connect@Database(connectionInfo)();
      q  = "DROP DATABASE if exists patient_data";
      println@Console(q)();
      update@Database(q)();
      q =  "CREATE DATABASE patient_data WITH OWNER =" + config.configData.username + " ENCODING = UTF8";
      println@Console(q)();
      update@Database(q)();
      close@Database()();

      with (connectionInfo) {
        .host=config.configData.location;
        .port= int (config.configData.port);
        .driver = config.configData.driver;
        .database= "patient_data";
        .username=config.configData.username;
        .password= config.configData.password
      };
      connect@Database(connectionInfo)();



      q= "CREATE TABLE public.physiology_data(mrm_key integer,name character varying ,value character varying) WITH ( OIDS = FALSE)";
      println@Console(q)();
      update@Database(q)();
      q = "CREATE SEQUENCE public.mrn_sequence INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1";
      println@Console(q)();
      update@Database(q)();
      q= "CREATE TABLE public.patient_data
              (
                  date_of_birth date,
                  name character varying ,
                  surname character varying,
                  ssn character varying ,
                  gender character varying,
                  mrn integer NOT NULL DEFAULT nextval('mrn_sequence'::regclass),
                  insurence_id character varying ,
                  insurence_nr character varying
                )
                WITH (
                  OIDS = FALSE
                  )";
      println@Console(q)();
      update@Database(q)();
      q= "CREATE TABLE public.physiology_data_type
              (
                  name character varying,
                  text character varying,
                  type_name character varying,
                  referance_table character varying,
                  type_var  character varying,
                  PRIMARY KEY (name)
              )
                WITH (
                    OIDS = FALSE
                  )";
      println@Console(q)();
      update@Database(q)();
      q= "CREATE TABLE public.physiology_data_range
            (
                name character varying,
                min character varying,
                max character varying,
                PRIMARY KEY (name)
            )
            WITH (
                OIDS = FALSE
                )";
        println@Console(q)();
        update@Database(q)()
}
}
