## PatientDataService
To install the DB you need to launch install.ol using the command jolie install
The connection paramenters are the following and they can be found.

```javascript
with (connectionInfo) {
   .host = "localhost";
   .driver = "sqlite";
   .username = "prova";
   .password = "prova";
   .database= "health_service.db"
 };
```
to start the service launch main_patient_data_service.ol
The imput port PatientDataPort

```javascript
inputPort PatientDataPort {
  Location: PatientDataServiceLocation
  Protocol: sodep
  Interfaces: PatientDataServiceInterface
}
```

The location is in [on GitHub](https://github.com/bmaschio/HealthServiceDemo/tree/master/PublicResources/config/locations.iol)

```javascript
constants {
  PatientDataServiceLocation = "socket://localhost:6100"
}
```

The test files for services is in [on GitHub](https://github.com/bmaschio/HealthServiceDemo/tree/master/PatientDataService/test)

