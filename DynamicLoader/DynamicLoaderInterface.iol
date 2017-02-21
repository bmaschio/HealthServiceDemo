type EntryRequest: void {
  .service_type: string /* patient or staff */
}

interface DynamicLoaderInterface {
  RequestResponse:
    entry( EntryRequest )( void ) throws ServiceTypeDoesNotExists,
    stop
}
