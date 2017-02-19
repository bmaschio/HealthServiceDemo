include "string_utils.iol"
include "console.iol"
include "./public/interfaces/PlannerInterface.iol"
include "time.iol"

inputPort PlannerPort {
Location: "socket://localhost:4002"
Protocol: sodep
Interfaces: PlannerInterface
}

execution{ concurrent }

main{
   [getResource(request)(response){
      run = true;
      counter =0;
      while (run){
        if (!is_defined( global.resources.(request.uniqueId[counter]).time)){
          getCurrentDateTime@Time()(currentTime);
          global.resources.(request.uniqueId[counter]).time = currentTime;
          response.date_time = currentTime;
          response.uniqueId = request.uniqueId[counter];
          run = false
        }else{
          nullProcess
        };
        counter++
      };
      valueToPrettyString@StringUtils(global.resources)(s);
      println@Console(s)()
   }]
}
