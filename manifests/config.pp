class pe_agent::config {
  include pe_agent::params

  $pe_install_version = $pe_agent::params::pe_install_version
  $pe_servername = $pe_agent::params::pe_servername

  file { '/etc/puppetlabs/facter':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0644,
  }

  file { '/etc/puppetlabs/facter/facts.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0644,
  }

  file { '/etc/puppetlabs/facter/facts.d/puppet_enterprise_installer.txt':
    ensure  => file,
    content => "fact_is_puppetagent=true
fact_stomp_port=61613
fact_stomp_server=${pe_servername}
fact_is_puppetmaster=false
fact_is_puppetca=false
fact_is_puppetconsole=false",
  }

  service { 'pe-puppet':
    ensure  => running,
    require => Package["pe-puppet"],
  }

  if $pe_install == "true" { 
    file {'/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      owner   => 'pe-puppet',
      group   => 'pe-puppet',
      mode    => 0600,
      content => template("pe_agent/puppet.conf.erb"),
      require => File['/opt/puppet/pe_version'],
    }
  }

  file { '/opt/puppet/pe_version':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 0400,
    content => "${pe_install_version}",
    require => Package["pe-puppet-enterprise-release"],
  }


  file { '/usr/local/bin/facter':
    ensure  => 'link',
    target  => '/opt/puppet/bin/facter',
    require => Package["pe-puppet-enterprise-release"],
  }

  file { '/usr/local/bin/puppet':
    ensure  => 'link',
    target  => '/opt/puppet/bin/puppet',
    require => Package["pe-puppet-enterprise-release"],
  }

  file { '/usr/local/bin/hiera':
    ensure  => 'link',
    target  => '/opt/puppet/bin/hiera',
    require => Package["pe-puppet-enterprise-release"],
  }

}
