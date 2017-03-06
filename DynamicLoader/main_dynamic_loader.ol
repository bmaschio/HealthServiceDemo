include "file.iol"
include "runtime.iol"
include "console.iol"
include "string_utils.iol"

include "DynamicLoaderInterface.iol"
include "ActivityInterface.iol"
include "../ServiceRegistry/public/interfaces/ServiceRegistryInterface.iol"

execution{ concurrent }

outputPort Activity {
  Interfaces: ActivityInterface
}

inputPort DynamicLoader {
  Location: "socket://localhost:3001"
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
              readFileRequest.filename = "../StaffService/main_staff_service.ol";
              readFile@File(readFileRequest)(readFileResponse);
              replaceAllRequest = readFileResponse;
              replaceAllRequest.replacement = "socket://localhost:7000" ;
              replaceAllRequest.regex = "\\blocalExt\\b";
              replaceAll@StringUtils(replaceAllRequest)(replaceAllResponse);
              writeFileRequest.filename= "./staff.ol";
              writeFileRequest.content = replaceAllResponse;
              writeFile@File(writeFileRequest)();
              emb.filepath ="./staff.ol"

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
