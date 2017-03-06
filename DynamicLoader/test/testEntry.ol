outputPort DynamicLoader {
  Location: "socket://localhost:3001"
  Protocol: sodep
  RequestResponse: entry
}

main {
  r.service_type = "staff";
  entry@DynamicLoader( r )( s )
}
