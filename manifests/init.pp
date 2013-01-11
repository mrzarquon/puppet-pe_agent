class pe_agent{
  include pe_agent::params

  $pe_install_version = $pe_agent::params::pe_install_version
  $pe_servername = $pe_agent::params::pe_servername

  #if agent checks in and already is up to date, don't do anything
  if $::pe_version != $pe_install_version {
    # install the bootstrap script to run puppet in non daemonized mode
    file { '/opt/puppet/bin/PUPPET_bootstrap':
      ensure => file,
      mode   => 0755,
      owner  => root,
      group  => root,
      source => 'puppet:///modules/pe_agent/PUPPET_bootstrap.sh',
    }
    exec { 'puppet_bootstrap':
      command => "/opt/puppet/bin/PUPPET_bootstrap -u -i -m ${pe_servername}",
      require => File['/opt/puppet/bin/PUPPET_bootstrap'],
    }
    notify { "Upgrade Status":
      loglevel => info,
      message  => "Current PE version '${pe_version}' is not at desired version '${pe_install_version}', upgrade initiating",
      require  => Exec['puppet_bootstrap'],
    }
  }

  #these facts are only set by the bootstrap script, so we know the agent is running daemonless
  #this is the actual installation actions
  if $pe_install == 'true' or $pe_upgrade == 'true' {
    case $operatingsystem {
      #by calling the include this way, each version of PE just needs to drop a corresponding folder of manifests for distribution into /opt/puppet/share/puppet/modules/pe_agent
      centos, redhat: { include pe_agent::$pe_install_version::el }
      default: { fail("unsupported platform") } 
    }
  }



}
