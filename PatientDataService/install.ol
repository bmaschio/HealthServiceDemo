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

      with (connectionInfo) {
        .host=config.location;
        .port= int (config.port);
        .driver = config.driver;
        .database= config.startingdb;
        .username=config.username;
        .password= config.password
      };
      connect@Database(request)();
      q = "CREATE DATABASE 'PatientData' WITH OWNER = postgres ENCODING = 'UTF8'";
      update@Database(q)();
      close@Database()();

      with (connectionInfo) {
        .host=config.location;
        .port= int (config.port);
        .driver = config.driver;
        .database= "PatientData";
        .username=config.username;
        .password= config.password
      };
      connect@Database(request)();

      undef(q);
      q= "CREATE TABLE public.physiology_data(mrm_key integer,name character varying ,value character varying) WITH ( OIDS = FALSE)"
      update@Database(q)();
      undef(q);
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
                  )"
      update@Database(q)();

      undef(q);
      q= "CREATE TABLE public.physiology_data(mrm_key integer,name character varying ,value character varying) WITH ( OIDS = FALSE)"
      update@Database(q)();

}
