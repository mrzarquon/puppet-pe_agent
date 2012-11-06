class pe_agent{

  #if agent checks in and already is up to date, don't do anything
  if $::pe_version == $version {
    notify { "Upgrade Status":
      loglevel => info,
      message  => "Current PE version '${pe_version}' at desired version '${version}'; not managing upgrade resources",
    }
  }
  else {
    case $operatingsytem {
      centos, redhat: { include pe_agent::el }
      default: { include pe_upgrade}
    }
  }




}
