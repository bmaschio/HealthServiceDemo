include "../public/interfaces/GeneralStaffInterface.iol"
include "time.iol"

outputPort StaffExt {
  Location: "socket://localhost:7000"
  Protocol: sodep
  Interfaces: GeneralStaffInterface
}


main{
  request.patientId = "First_Patient";
  request.patientLoc = "socket://localhost:8003";
  getCurrentDateTime@Time()(currentTime);
  request.time = currentTime;
  addVisit@StaffExt(request)();
  getVisit@StaffExt()(response)
}
