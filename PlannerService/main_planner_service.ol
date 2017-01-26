include "string_utils.iol"
include "console.iol"
include "database.iol"
include "./public/interfaces/PlannerInterface.iol"


execution{ concurrent }

main{
  [createPlan(request)(response){
    scope (createPlanScope){
      install (default=> valueToPrettyString@StringUtils(createPlanScope)(s);
            println@Console(s)());
       q.statement[0] = "insert into plan_header ( mrn , doctor , date ) values ()( mrn , doctor , to_date(:date, 'dd/MM/yyyy' )";
       q.statement[0].name = request.name;
       q.statement[0].doctor = request.doc;
       q.statement[0].date = request.date;
       q.statement[1] = "select currval('plan_sequence') as cur_val";
       executeTransaction@Database(q)(resultQ);
       valueToPrettyString@StringUtils(resultQ)(s);
       println@Console(s)();
       response.plan_id = resultQ.result[1].row.cur_val
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
      scope (deletePlanScope){
        install (default=> valueToPrettyString@StringUtils(deletePlanScope)(s);
              println@Console(s)());
              q.statament[0]= "insert into plan_step (plan_id , function , data)";
              q.statement[0].plan_id = plan_id;
                         q.statament[1]= "delete from plan_header where plan_id = :plan_id";
                         q.statement[1].plan_id = plan_id;

    }]

}
