type GetResorceRequest:void{
  .uniqueId*: string
}

type GetResouceResponse: void {
  .date_time: string
  .uniqueId : string
}


interface PlannerInterface {
  RequestResponse:
    getResource(GetResorceRequest)(GetResouceResponse)
}
