class pe_agent::params{

  #below is magical regex i need to actually get working
  $pe_serverversion = regsubst($serverversion,'^.*?\([^\d]*(\d+)[^\d]*\).*$','\0')
  $pe_install_version = pick($::pe_env_version, hiera('pe_env_version', $pe_serverversion))
  $pe_servername = pick($::pe_env_server, hiera('pe_env_server', $servername))
  $pe_repo = pick($$::pe_env_repo, hiera('pe_env_server', $servername))

}
