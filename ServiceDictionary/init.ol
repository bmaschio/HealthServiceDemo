include "../ActivityRegistry/ActivityInterface.iol"
include "console.iol"
include "string_utils.iol"

inputPort Activity {
  Location: "local"
  Protocol: sodep
  Interfaces: ActivityInterface
}

inputPort ActivityExt {
  Location: "socket://localhost:5001"
  Protocol: sodep
  Interfaces: ActivityInterface
}
execution{ concurrent}
init{
  valueToPrettyString@StringUtils(global)(s);
  println@Console(s)();
  global.status = "first"
}

main{
  [run (request)(response){
      response.status = global.status;
      response.stop = false;
      if ( global.status =   )
  }]
  [close_step (request)(response){
     nullProcess
  }]
}
