class pe_agent{

  $version = "2.6.1"

  #if agent checks in and already is up to date, don't do anything
  if $::pe_version == $version {
    notify { "Upgrade Status":
      loglevel => info,
      message  => "Current PE version '${pe_version}' at desired version '${version}'; not managing upgrade resources",
    }
  }
  else {
    # install the bootstrap script to run puppet in non daemonized mode
    file { '/opt/puppet/bin/PUPPET_bootstrap':
      ensure => file,
      mode   => 0755,
      owner  => root,
      group  => root,
      source => 'puppet:///modules/pe_agent/PUPPET_bootstrap.sh',
    }
    exec { 'puppet_bootstrap':
      command => "/opt/puppet/bin/PUPPET_bootstrap --environment=pe_bootstrap --server=master --upgrade=true",
      require => File['/opt/puppet/bin/PUPPET_bootstrap'],
    }
  }

  #these facts are only set by the bootstrap script, so we know the agent is running daemonless
  #this is the actual installation actions
  if $pe_install == 'true' or $pe_upgrade == 'true' {
    case $operatingsystem {
      centos, redhat: { include pe_agent::el }
      default: { fail("unsupported platform") } 
    }
  }



}
