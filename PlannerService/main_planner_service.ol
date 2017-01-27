include "string_utils.iol"
include "console.iol"
include "database.iol"
include "xml_utils.iol"
include "file.iol"
include "./public/interfaces/PlannerInterface.iol"

inputPort PlannerPort {
Location: "socket://localhost:4002"
Protocol: sodep
Interfaces: PlannerInterface
}

execution{ concurrent }
init {
  with (requestReadFile) {
         .filename = "config.xml";
         .format="xml"
   };

   readFile@File(requestReadFile)(config);
  with (connectionInfo) {
    .host=config.configData.location;
    .port= int (config.configData.port);
    .driver = config.configData.driver;
    .database= "patient_plan";
    .username=config.configData.username;
    .password= config.configData.password
  };
  connect@Database(connectionInfo)()
}

main{
  [createPlan(request)(response){
    scope (createPlanScope){
      install (default=> valueToPrettyString@StringUtils(createPlanScope)(s);
            println@Console(s)());
       q.statement[0] = "insert into plan_header ( mrn , doctor , date ) values ( :mrn , :doctor , to_date(:date, 'dd/MM/yyyy' ))";
       q.statement[0].mrn = request.mrn;
       q.statement[0].name = request.name;
       q.statement[0].doctor = request.doc;
       q.statement[0].date = request.date;
       q.statement[1] = "select currval('plan_sequence') as cur_val";
       executeTransaction@Database(q)(resultQ);
       valueToPrettyString@StringUtils(resultQ)(s);
       println@Console(s)();
       response.plan_id = int (resultQ.result[1].row.cur_val)
      }
    }]

  [deletePlan(request)(response){
    scope (deletePlanScope){
      install (default=> valueToPrettyString@StringUtils(deletePlanScope)(s);
            println@Console(s)());
           q.statament[0]= "delete from plan_step where plan_id = :plan_id";
           q.statement[0].plan_id = plan_id;
           q.statament[1]= "delete from plan_header where plan_id = :plan_id";
           q.statement[1].plan_id = plan_id;
           executeTransaction@Database(q)(resultQ);
           valueToPrettyString@StringUtils(resultQ)(s);
           println@Console(s)()

     }
    }]

    [addStepToPlan(request)(response){
      scope (addStepToPlanScope){
        install (default=> valueToPrettyString@StringUtils(addStepToPlanScope)(s);
              println@Console(s)());
              valueToXmlRequest.rootNodeName = "data";
              valueToXmlRequest.root << request;
              valueToXml@XmlUtils(valueToXmlRequest)(responseToXmlResponse);
              q.statement[0]= "insert into plan_step (plan_id , function , data) values (:plan_id , :function , :data)";
              q.statement[0].plan_id = request.plan_id;
              q.statement[0].function = request.function;
              q.statement[0].data =  responseToXmlResponse;
              q.statement[1] = "select currval('plan_step_sequence') as cur_val";
              for (counter=0 , counter<#request.prerequisit, counter++ ){
                q.statement[2 + counter] = "insert into plan_step_pre (plan_id, step_id , prereq ) values (:plan_id, currval('plan_step_sequence') ,:prereq )";
                q.statement[2 + counter].plan_id = request.plan_id;
                q.statement[2 + counter].prereq = request.prerequisit[counter]
              };
              valueToPrettyString@StringUtils(q)(s);
              println@Console(s)();
              executeTransaction@Database(q)(resultQ);
              valueToPrettyString@StringUtils(resultQ)(s);
              println@Console(s)();
              response.step_id = int (resultQ.result[1].row.cur_val)
        }
    }]
  [processPlan(request)(response){
    scope (addStepToPlanScope){
      install (default=> valueToPrettyString@StringUtils(processPlanScope)(s);
               println@Console(s)());
               q= "select * from  plan_step where step_id not in (select step_id from plan_step_pre) and  completed = 'false' and execution = 'false' and plan_id = :plan_id";
               q.plan_id = request.plan_id;
               valueToPrettyString@StringUtils(q)(s);
               println@Console(s)();
               query@Database(q)(responseq);
               valueToPrettyString@StringUtils(responseq)(s);
               println@Console(s)();
               if (#responseq.row > 0){
               //starting first steps
              for (counter=0 , counter<#responseq.row, counter++ ){
                     println@Console("Calling " + responseq.row[counter].function + " for step " +  responseq.row[counter].step_id )();
                 undef( q);
                 q = "update plan_step set execution =:execution where plan_id = :plan_id and step_id = :step_id ";
                 q.plan_id = request.plan_id;
                 q.step_id = request.step_id;
                 q.execution = true;
                 update@Database(q)()
               }

               }
          }

    }]
}
