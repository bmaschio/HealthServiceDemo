outputPort DynamicLoader {
  Location: "socket://localhost:10000"
  Protocol: sodep
  RequestResponse: entry
}

main {
  r.service_type = "staff";
  entry@DynamicLoader( r )( s )
}
