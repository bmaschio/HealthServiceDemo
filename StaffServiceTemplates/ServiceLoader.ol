include "../DynamicLoader/public/interfaces/DynamicLoaderInterface.iol"
include "../PublicResources/config/locations.iol"
include "file.iol"
include "console.iol"
include "string_utils.iol"

outputPort DynamicLoader {
  Location: DynamicLoaderLocation
  Protocol: sodep
  Interfaces: DynamicLoaderInterface
}
main {

  readFileRequest.filename = "WorkflowList.xml";
  readFileRequest.format = "xml";
  readFile@File(readFileRequest)(readFileResponse);
  requestRegisterServices << readFileResponse.List_Of_Services;
  valueToPrettyString@StringUtils(requestRegisterServices)(s);
  println@Console(s)();
  registerServices@DynamicLoader(requestRegisterServices)()

}
