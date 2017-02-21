include "file.iol"
include "runtime.iol"
include "console.iol"
include "string_utils.iol"

include "DynamicLoaderInterface.iol"
include "ActivityInterface.iol"

execution{ concurrent }

outputPort Activity {
  Interfaces: ActivityInterface
}

inputPort DynamicLoader {
  Location: MyLocation
  Protocol: sodep
  Interfaces: DynamicLoaderInterface
}

init {
  println@Console( "Running DynamicLoader... ")()
}


main {

    [ entry( request )( response ) {
          println@Console( "DynamicLoader: Received initialization request for service_type " + request.service_type )();
          service_type = request.service_type;
          emb.type = "Jolie";
          if( service_type == "staff" ) {
              emb.filepath ="../StaffService/main_staff_service.ol"
          } else if( service_type == "patient" ) {
              /*TODO*/
              emb.filepath = ""
          } else {
              throw( ServiceTypeDoesNotExists )
          }
          ;
          run_activity.stop = false
          ;
          scope (loadEmbeddedService) {
                  loadEmbeddedService@Runtime( emb )( Activity.location );
                  run@Activity()( run_activity )
          }
    }]

    [ stop( request )( response ) {
        exit
    }]
}
