include "../public/interfaces/DynamicLoaderInterface.iol"
include "../../PublicResources/config/locations.iol"


outputPort DynamicLoader {
  Location: DynamicLoaderLocation
  Protocol: sodep
  Interfaces: DynamicLoaderInterface
}

main {
  r.service_group= "PATIENT";
  r.service_type = "GenericPatient";
  r.service_code = "check_up_wf";
  entry@DynamicLoader( r )( s )
}
