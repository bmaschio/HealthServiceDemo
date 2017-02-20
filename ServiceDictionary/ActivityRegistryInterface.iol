type GetActivityRequest: void {
  .name: string
}

interface ActivityRegistryInterface {
  RequestResponse:
    getActivity( GetActivityRequest )( string )
}
