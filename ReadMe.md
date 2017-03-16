# HealthServiceDemo

This project is Test Project that demostrates the posibility of developing EMR Workflow Manager using Jolie.
The approch used is that of process centric architecture.

## Project Structure 

* StaffServiceTemplates : contains the microservices that models the different specialization this microservices will be loaded dynamicly via the DynamicLoader
* PatientWfTemplates: contains the designed workflow for patient EMR Workflow
* PublicResources: contains all the interfaces definition implemented by the microservices, this folder guarantees cross visibility between the microservices
* DynamicLoader: Dynamically executes the services using a range of ports
* ServiceRegistry: the registry of all the running microservices provides available microservices
* PlannerService: Very basic resorces planning capability ( really dunny )
* PatientDataService: provides some basic data consolidation capabilitis run on sqlite no DB engine required

