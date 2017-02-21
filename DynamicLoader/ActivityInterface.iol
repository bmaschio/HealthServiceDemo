type RunResponse:void{
    .stop : bool
}

interface ActivityInterface {
  RequestResponse:
    run( void )( RunResponse )
}
