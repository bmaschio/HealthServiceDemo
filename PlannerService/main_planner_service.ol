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
/* This Service simulates the resorses planning */
main{
   [getResource(request)(response){
      run = true;
      counter =0;
      oldTime = 9999999999999L;
      while (run){
        if (!is_defined( global.resources.(request.uniqueId[counter]).time)){
          getCurrentDateTime@Time()(currentTime);
          global.resources.(request.uniqueId[counter]).time = currentTime;
          response.date_time = currentTime;
          response.uniqueId = request.uniqueId[counter];
          foundNew = true;
          run = false
        }else{
          getTimestampFromString@Time(global.resources.(request.uniqueId[counter]).time)(timeInMill);
          if (timeInMill < oldTime){
            oldTime = timeInMill;
            counterFound = counter
          }
        };
        if (counter == #request.uniqueId -1 ){
          run = false
        };
        counter++
      };

     if (is_defined (counterFound)){
         oldTime = oldTime + 900000;
         getDateTime@Time(oldTime)(timeInString);
         global.resources.(request.uniqueId[counterFound]).time = timeInString;
         if (!foundNew){
              response.date_time = global.resources.(request.uniqueId[counterFound]).time;
              response.uniqueId = request.uniqueId[counterFound]
        }
      }
   }]
}
