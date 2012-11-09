class pe_agent::enabled {
  include inifile

  ini_setting { "pe_bootstrap_modulepath":
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'pe_bootstrap',
    setting => 'modulepath',
    value   => '\$confdir/environments/pe_bootstrap/modules',
    ensure  => present,
  }

  ini_setting { "pe_bootstrap_manifest":
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'pe_bootstrap',
    setting => 'manifest',
    value   => '\$confdir/environments/pe_bootstrap/manifests/site.pp',
    ensure  => present,
  }
  

}
