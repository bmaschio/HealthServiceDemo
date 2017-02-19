include "file.iol"
include "runtime.iol"
include "console.iol"
include "string_utils.iol"

include "../ActivityRegistry/ActivityRegistryInterface.iol"
include "../ActivityRegistry/ActivityInterface.iol"
include "../locations.iol"

outputPort Activity {
  Interfaces: ActivityInterface
}

outputPort ActivityRegistry {
  Location: ActivityRegistryLocation
  Protocol: sodep
  Interfaces: ActivityRegistryInterface
}

constants {
  CURRENT_ACTIVITY = "current_activity.ol"
}

main {
    run_activity.stop = false;
    run_activity.next = "init";

        activity_request.name = "init";
        getActivity@ActivityRegistry( activity_request )( activity );
        file.filename = emb.path = CURRENT_ACTIVITY;
        file.content = activity;
        writeFile@File( file )();
        undef(emb);
        emb.type = "Jolie";
        emb.filepath =CURRENT_ACTIVITY;
        valueToPrettyString@StringUtils(emb)(s);
        println@Console( s )();
        scope (loadEmbeddedService){
                  install (default =>        valueToPrettyString@StringUtils(loadEmbeddedService)(s);
                          println@Console("error" +s )() );
                  loadEmbeddedService@Runtime( emb )( Activity.location );
                  valueToPrettyString@StringUtils(Activity)(s);
                  println@Console( s )();
        run@Activity()( run_activity )
    }
}
