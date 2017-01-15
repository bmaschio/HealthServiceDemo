include "../public/interfaces/PatientDataServiceInterface.iol"

outputPort PatientDataPort {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: PatientDataServiceInterface , PatientDataServiceSupportInterface
}

main{
   with (request){
     .name = "blood_type";
     .text = "Blood Type";
     .type_name = "values_table";
     .type_var =  "string";
     .referance_table = "blood_type_table"
   };

   insertPhysiologyDataType@PatientDataPort(request)(response);
   undef (request);

   with (request){
     .name = "blood_pressure";
     .text = "Blood pressure";
     .type_name = "values_range";
     .type_var =  "double"
   };

   insertPhysiologyDataType@PatientDataPort(request)(response)

}
