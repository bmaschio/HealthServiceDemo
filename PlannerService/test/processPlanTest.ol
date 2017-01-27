include "../public/interfaces/PlannerInterface.iol"
include "string_utils.iol"
include "console.iol"

outputPort PlannerPort {
  Location: "socket://localhost:4002"
  Protocol: sodep
  Interfaces: PlannerInterface
}


main{
  with (processPlanRequest){
      .plan_id = 3
  };

  valueToPrettyString@StringUtils(processPlanRequest)(s);
  println@Console(s)();
  processPlan@PlannerPort(processPlanRequest)()

}
