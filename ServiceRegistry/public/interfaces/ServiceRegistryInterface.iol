type Location: void {
  .host: string
  .port: int
}


type serviceType:void{
    .serviceCategory:string
    .location:string
}

type AddServiceRequest:void{
    .service: serviceType
}

type AddServiceResponse:void{
   .uniqueId:string
}

type RemoveServiceRequest:void{
  .serviceCategory:string
  .uniqueId:string
}

type RemoveServiceResponse:void

type SearchServiceRequest:void{
    .serviceCategory:string
}

type SearchServiceResponse:void{
    .service*: void{
        .uniqueId:string
        .location:string
    }
}

interface ServiceRegistryInterface {
  RequestResponse:
   getNextLocation( void )( Location ),
   addService    (AddServiceRequest)(AddServiceResponse),
   removeService (RemoveServiceRequest)(RemoveServiceResponse),
   searchService (SearchServiceRequest)(SearchServiceResponse)
}
