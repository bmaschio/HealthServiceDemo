type RunResponse:void{
  .stop : bool
}
type AddVisitRequest:void{
   .patientId: string
   .patientLoc: string
   .time: string

}

type AddVisitResponse:void

type GetVisitRequest:void

type GetVisitResponse:void{
    .visit*:void{
      .patientId: string
      .patientLoc: string
      .time: string

    }
}
interface GeneralStaffInterface {
RequestResponse:
  run(undefined)(RunResponse),
  stop(undefined)(undefined),
  addVisit(AddVisitRequest)(AddVisitResponse),
  getVisit(GetVisitRequest)(GetVisitResponse)
}
