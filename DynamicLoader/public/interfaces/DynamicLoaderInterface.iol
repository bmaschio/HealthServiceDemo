type EntryRequest: void {
  .service_group: string /* patient or staff */
  .service_type: string 
  .service_code: string
}

type RegisterServicesRequest:any{
  .service_group: string
  .service*:any{
    .service_type: string
    .service_description:string
    .service_file:string
    .service_code:string
  }
}

type RegisterServicesResponse:void

type GetServiceTypeRequest:void{
   .service_group: string
}

type GetServiceTypeResponse:void{
   .service_type*:string
}
type ServiceCodeType:void{
  .service_description:string
  .service_code:string
}

type GetServiceCodeRequest:void{
  .service_type:string
}
type GetServiceCodeResponse:void{
  .service_code*: ServiceCodeType
}


interface DynamicLoaderInterface {
  RequestResponse:
    entry( EntryRequest )( void ) throws ServiceTypeDoesNotExists,
    registerServices(RegisterServicesRequest)(RegisterServicesResponse),
    getServiceType(GetServiceTypeRequest)(GetServiceTypeResponse),
    getServiceCode(GetServiceCodeRequest)(GetServiceCodeResponse),
    stop(undefined)(undefined),
}
