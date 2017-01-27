include "../public/interfaces/PlannerInterface.iol"
include "string_utils.iol"
include "console.iol"

outputPort PlannerPort {
  Location: "socket://localhost:4002"
  Protocol: sodep
  Interfaces: PlannerInterface
}


main{
  with (createPlanRequest){
     .mrn = 1;
     .doctor= "rossi";
     .date= "27/01/2017"
  };

  valueToPrettyString@StringUtils(createPlanRequest)(s);
  println@Console(s)();
  createPlan@PlannerPort(createPlanRequest)(createPlanResponse);
  valueToPrettyString@StringUtils(createPlanResponse)(s);
  println@Console(s)();

  with (addStepToPlanRequest) {
    .plan_id = createPlanResponse.plan_id;
    .function = "IMAGING_SERVICE";
    .data[0].name = "MRN";
    .data[0].value = "1";
    .data[1].name = "EXAM_TYPE";
    .data[1].value = "PET"
  };

  valueToPrettyString@StringUtils(addStepToPlanRequest)(s);
  println@Console(s)();

  addStepToPlan@PlannerPort(addStepToPlanRequest)(addStepToPlanResponse);
  valueToPrettyString@StringUtils(addStepToPlanResponse)(s);
  println@Console(s)();
  stepHistory.prerequisit[0] = addStepToPlanResponse.step_id;
  undef (addStepToPlanRequest);

  with (addStepToPlanRequest) {
    .plan_id = createPlanResponse.plan_id;
    .function = "BLOOD_SERVICE";
    .data[0].name = "MRN";
    .data[0].value = "1";
    .data[1].name = "EXAM_TYPE";
    .data[1].value = "COLESTEROL"
  };

  valueToPrettyString@StringUtils(addStepToPlanRequest)(s);
  println@Console(s)();

  addStepToPlan@PlannerPort(addStepToPlanRequest)(addStepToPlanResponse);
  valueToPrettyString@StringUtils(addStepToPlanResponse)(s);
  println@Console(s)();
  stepHistory.prerequisit[1] = addStepToPlanResponse.step_id;


  addStepToPlanRequest << stepHistory;
  with (addStepToPlanRequest) {
    .plan_id = createPlanResponse.plan_id;
    .function = "SPECIALIST_SERVICE";
    .data[0].name = "MRN";
    .data[0].value = "1";
    .data[1].name = "EXAM_TYPE";
    .data[1].value = "ONCOLOGIST"
  };

  valueToPrettyString@StringUtils(addStepToPlanRequest)(s);
  println@Console(s)();

  addStepToPlan@PlannerPort(addStepToPlanRequest)(addStepToPlanResponse);
  valueToPrettyString@StringUtils(addStepToPlanResponse)(s);
  println@Console(s)();
  undef (stepHistory);
  stepHistory.prerequisit[0] = addStepToPlanResponse.step_id;
  valueToPrettyString@StringUtils(stepHistory)(s);
  println@Console(s)();

  addStepToPlanRequest << stepHistory;
  with (addStepToPlanRequest) {
    .plan_id = createPlanResponse.plan_id;
    .function = "SPECIALIST_SERVICE";
    .data[0].name = "MRN";
    .data[0].value = "1";
    .data[1].name = "EXAM_TYPE";
    .data[1].value = "SURGERY"
  };

  valueToPrettyString@StringUtils(addStepToPlanRequest)(s);
  println@Console(s)();

  addStepToPlan@PlannerPort(addStepToPlanRequest)(addStepToPlanResponse);
  valueToPrettyString@StringUtils(addStepToPlanResponse)(s);
  println@Console(s)();
  undef (stepHistory);
  stepHistory.prerequisit[0] = addStepToPlanResponse.step_id;
  valueToPrettyString@StringUtils(stepHistory)(s);
  println@Console(s)()


}
