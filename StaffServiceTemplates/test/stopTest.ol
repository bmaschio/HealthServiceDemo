include "../public/interfaces/GeneralStaffInterface.iol"

outputPort StaffExt {
  Location: "socket://localhost:7000"
  Protocol: sodep
  Interfaces: GeneralStaffInterface
}


main{
  stop@StaffExt()()
}
