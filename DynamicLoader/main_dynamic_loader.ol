include "file.iol"
include "runtime.iol"
include "console.iol"
include "string_utils.iol"

include "./public/interfaces/DynamicLoaderInterface.iol"



include "../PublicResources/interfaces/ActivityInterface.iol"
include "../ServiceRegistry/public/interfaces/ServiceRegistryInterface.iol"
include "../PublicResources/config/locations.iol"
execution{ concurrent }

outputPort Activity {
  Interfaces: ActivityInterface
}

outputPort ServiceRegistryPort {
    Location: ServiceRegistryLocation
    Protocol: sodep
    Interfaces: ServiceRegistryInterface
}

inputPort DynamicLoader {
  Location: DynamicLoaderLocation
  Protocol: sodep
  Interfaces: DynamicLoaderInterface
}

init {
  println@Console( "Running DynamicLoader... ")()
}


main {

    [ entry( request )( response ) {
          println@Console( "DynamicLoader: Received initialization request for service_type " + request.service_type )();
          emb.type = "Jolie";
          readFileRequest.filename = global.services.(request.service_group).(request.service_type).(request.service_code).service_file;
          readFile@File(readFileRequest)(readFileResponse);
          serviceStarted = false;
          while (!serviceStarted){
                  getNextLocation@ServiceRegistryPort()(responseGetNextLocation);
                  replaceAllRequest = readFileResponse;
                  replaceAllRequest.replacement = "socket://localhost:"+responseGetNextLocation.port ;
                  replaceAllRequest.regex = "\\blocalExt\\b";
                  replaceAll@StringUtils(replaceAllRequest)(replaceAllResponse);
                  writeFileRequest.filename= "./DynamicService_"+ responseGetNextLocation.port + ".ol";
                  writeFileRequest.content = replaceAllResponse;
                  writeFile@File(writeFileRequest)();
                  emb.filepath = writeFileRequest.filename;
                  scope (loadEmbeddedService) {
                          loadEmbeddedService@Runtime( emb )( Activity.location );
                          serviceStarted = true;
                          init_service@Activity()( run_activity )
                  }
            }

    }]

    [ stop( request )( response ) {
        exit
    }]

    [registerServices(request)(response){
         /* Clearing old  data */
         undef ( global.services.(request.service_group));
         /* Adding data*/
         for (counter =0 , counter< #request.service, counter++){
             global.services.(request.service_group).(request.service[counter].service_type).(request.service[counter].service_code).service_description = request.service[counter].service_description;
             global.services.(request.service_group).(request.service[counter].service_type).(request.service[counter].service_code).service_file = request.service[counter].service_file
         };

         valueToPrettyString@StringUtils(global.services)(s);
         println@Console(s)()

      }]
}
