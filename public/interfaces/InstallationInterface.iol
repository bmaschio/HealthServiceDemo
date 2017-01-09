type SetConfigFileRequest:void{
  .configData*:void{
    .name:string
    .value:string
  }
}

type SetConfigFileResponse:void

type runInstallRequest:void

type runInstallResponse:void

type diagnosticInstallRequest:void

type diagnosticInstallRespone:void{
  .checkResult*: string
}

interface InstallationInterface {
RequestResponse:
    setConfigFile(SetConfigFileRequest)(SetConfigFileResponse),
    runInstall (runInstallRequest)(runInstallResponse),
    diagnosticInstall (diagnosticInstallRequest)(diagnosticInstallResponse)
}
