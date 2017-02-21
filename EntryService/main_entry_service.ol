include "console.iol"
include "exec.iol"
include "time.iol"

include "../ServiceRegistry/public/interfaces/ServiceRegistryInterface.iol"
include "../DynamicLoader/DynamicLoaderInterface.iol"

include "../locations.iol"

outputPort DynamicLoader {
  Protocol: sodep
  Interfaces: DynamicLoaderInterface
}

outputPort ServiceRegistry {
  Location: ServiceRegistryLocation
  Protocol: sodep
  Interfaces: ServiceRegistryInterface
}

init {
  registerForInput@Console()()
}

main {
  while( true ) {
      print@Console( "Insert service type to enable (patient|staff): ")();
      in( request.service_type );
      getNextLocation@ServiceRegistry()( location );
      DynamicLoader.location = "socket://" + location.host + ":" + location.port;
      cmd = "jolie";
      with( cmd ) {
          .args[ 0 ] = "-C";
          .args[ 1 ] = "MyLocation=\"" + DynamicLoader.location + "\"";
          .args[ 2 ] = "main_dynamic_loader.ol";
          .waitFor = 0;
          .stdOutConsoleEnable = true;
          .workingDirectory = "../DynamicLoader"
      }
      ;
      exec@Exec( cmd )();
      sleep@Time( 2000 )();
      entry@DynamicLoader( request )()
  }

}
