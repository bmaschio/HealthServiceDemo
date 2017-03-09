type RunResponse:void{
    .stop : bool
}

interface ActivityInterface {
  RequestResponse:
    init_service ( undefined )(undefined),
    stop_service (undefined) (undefined)
}
