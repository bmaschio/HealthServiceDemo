include "string_utils.iol"
include "console.iol"
include "../public/interfaces/PlannerInterface.iol"
include "time.iol"

outputPort PlannerPort {
Location: "socket://localhost:4002"
Protocol: sodep
Interfaces: PlannerInterface
}


main{
  request.uniqueId[0] ="a";
  request.uniqueId[1] ="b";
  getResource@PlannerPort(request)(response)
}
