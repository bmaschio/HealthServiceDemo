type RunActivityResponse: void {
  .location? :string
  .stop?: bool
}

interface ActivityInterface {
  RequestResponse:
    run( undefined )( undefined ),
    close_step (undefined)(undefined)
}
