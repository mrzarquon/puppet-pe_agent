class pe_agent::params{

  #below is magical regex i need to actually get working
  $pe_serverversion = regsubst($serverversion,'^.*?\([^\d]*(\d+)[^\d]*\).*$','\0')
  $pe_install_version = pick($::pe_desired_version, hiera('pe_desired_version', $pe_serverversion))
  $pe_servername = pick($::pe_desired_server, hiera('pe_desired_server', $servername))


}
