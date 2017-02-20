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
  println@Console(s)()
}

main{
  run (request)(response){
      println@Console("test")()
  };
  close_step (request)(response){
     nullProcess
  }
}
