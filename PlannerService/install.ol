include "console.iol"
include "string_utils.iol"
include "database.iol"
include "file.iol"
include "xml_utils.iol"

main{
scope (InstallScope){

install (default=> valueToPrettyString@StringUtils(InstallScope)(s);
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
q = "DROP DATABASE if exists patient_plan";
println@Console(q)();
update@Database(q)();
q =  "CREATE DATABASE patient_plan WITH OWNER =" + config.configData.username + " ENCODING = UTF8";
println@Console(q)();
update@Database(q)();
close@Database()();

with (connectionInfo) {
  .host=config.configData.location;
  .port= int (config.configData.port);
  .driver = config.configData.driver;
  .database= "patient_plan";
  .username=config.configData.username;
  .password= config.configData.password
};
connect@Database(connectionInfo)();


q ="CREATE SEQUENCE public.plan_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1";
println@Console(q)();
update@Database(q)();

q = "CREATE SEQUENCE public.plan_step_sequence
        INCREMENT 1
        START 2
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1";
println@Console(q)();
update@Database(q)();

q ="CREATE TABLE public.plan_header
        (
            mrn integer,
            doctor character varying ,
            plan_id integer NOT NULL DEFAULT nextval('plan_sequence'::regclass),
            date date,
            CONSTRAINT plan_header_pkey PRIMARY KEY (plan_id)
        )
        WITH (
            OIDS = FALSE
        )";
  println@Console(q)();
  update@Database(q)();


q = "CREATE TABLE public.plan_step
      (
          plan_id integer,
          step_id integer NOT NULL DEFAULT nextval('plan_step_sequence'::regclass),
          function character varying,
          data character varying,
          completed boolean DEFAULT false,
          execution boolean DEFAULT false
)
WITH (
    OIDS = FALSE
)";
println@Console(q)();
update@Database(q)();

q ="CREATE TABLE public.plan_step_pre
(
    plan_id integer,
    step_id integer,
    prereq integer
)
WITH (
    OIDS = FALSE
)";
println@Console(q)();
update@Database(q)()
}

}
