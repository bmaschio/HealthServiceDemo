type RunActivityResponse: void {
  .next: string
  .stop: bool
}

interface ActivityInterface {
  RequestResponse:
    run( undefined )( RunActivityResponse )
}
