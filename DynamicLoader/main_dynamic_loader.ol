include "file.iol"
include "runtime.iol"
include "console.iol"
include "string_utils.iol"
include "../StaffService/public/interfaces/GeneralStaffInterface.iol"


outputPort StaffService {
  Interfaces: GeneralStaffInterface
}



main {
       run_activity.stop = false;

        undef(emb);
        emb.type = "Jolie";
        emb.filepath ="../StaffService/main_staff_service.ol";
        valueToPrettyString@StringUtils(emb)(s);
        println@Console( s )();
        scope (loadEmbeddedService){
                  install (default =>        valueToPrettyString@StringUtils(loadEmbeddedService)(s);
                          println@Console("error" +s )() );
                  loadEmbeddedService@Runtime( emb )( StaffService.location );
                  valueToPrettyString@StringUtils(Activity)(s);
                  println@Console( s )();
        while (!run_activity.stop)  {
           run@StaffService()( run_activity )
        }
    }
}
