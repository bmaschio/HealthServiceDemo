include "file.iol"

include "ActivityRegistryInterface.iol"

include "../locations.iol"

execution{ concurrent }

inputPort ActivityRegistry {
  Location: ActivityRegistryLocation
  Protocol: sodep
  Interfaces: ActivityRegistryInterface
}

main {
  getActivity( request )( response ) {
      file.filename = request.name + ".ol";
      readFile@File( file )( response )
  }
}
