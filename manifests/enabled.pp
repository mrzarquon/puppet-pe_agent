class pe_agent::enabled {
  include inifile

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
