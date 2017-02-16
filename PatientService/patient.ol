include "file.iol"
include "runtime.iol"

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

    while( !run_activity.stop ) {
        getActivity@ActivityRegistry( activity_request )( activity );
        file.filename = emb.path = CURRENT_ACTIVITY;
        file.content = activity;
        writeFile@File( file )();

        emb.type = "Jolie";
        loadEmbeddedService@Runtime( emb )( Activity.location );
        run@Activity()( run_activity )
    }
}
