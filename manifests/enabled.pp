class pe_agent::enabled {
  # this still isn't working / testing code.
  # The purpose of this class is to allow you to create the pe_bootstrap environment on a 
  # master in your environment (probably the same one acting as the CA), that will then 
  # do the basic site.pp classification of a node to assign it the pe_agent class.
  # This enables being able to bootstrap agents that have just had the pe-puppet package 
  # installed to have their /etc/puppetlabs/puppet.conf written properly, and the rest of
  # the PE packages (and mcollective) to be installed, accomplishing the same function as
  # puppet node install, but in puppet not bash.

  # The other function that this environment serves is for upgrading an agent. Since the
  # upgrade process itself happens as a forked bash triggered process after the daemonized
  # agent run completes, we want a minimal catalog for the agent to run against. We are just
  # upgrading the pe_agent realated packages. Once it finishes that run, it returns to the
  # normal environment it was configured and checks in again, bringing it fully back to 
  # upgraded node status.


  ini_setting { "pe_bootstrap_modulepath":
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'pe_bootstrap',
    setting => 'modulepath',
    value   => '/opt/puppet/share/puppet/environments/pe_bootstrap/modules',
    ensure  => present,
  }

  ini_setting { "pe_bootstrap_manifest":
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'pe_bootstrap',
    setting => 'manifest',
    value   => '/opt/puppet/share/puppet/environments/pe_bootstrap/manifests/site.pp',
    ensure  => present,
  }

  file { '/opt/puppet/share/puppet/environments':
    ensure => directory,
    mode   => 0644,
    owner  => root,
    group  => root,
  }

  file { '/opt/puppet/share/puppet/environments/modules/':
    ensure => link,
    target => '/opt/puppet/share/puppet/modules',
  }

  file { '/opt/puppet/share/puppet/environments/manifests':
    ensure => directory,
    mode   => 0644,
    owner  => root,
    group  => root,
  }

  file { '/opt/puppet/share/puppet/environments/manifests/site.pp':
    ensure => file,
    mode   => 0644,
    owner  => root,
    group  => root,
    source => "puppet:///pe_agent/site.pp",
  }
}
