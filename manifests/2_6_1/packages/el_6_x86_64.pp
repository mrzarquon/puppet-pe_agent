class pe_agent::2.6.1::packages::el_6_x86_64 {
  
  Package { require => Class['pe_agent::yum'] }
  
  package { 'pe-ruby-libs': ensure => '1.8.7.370-1.pe.el6' }
  package { 'pe-facter': ensure => '1.6.10-1.pe.el6' }
  package { 'pe-ruby-rdoc': ensure => '1.8.7.370-1.pe.el6' }
  package { 'pe-rubygem-stomp': ensure => '1.1.9-3.pe.el6' }
  package { 'pe-ruby-shadow': ensure => '1.4.1-8.pe.el6' }
  package { 'pe-rubygem-hiera': ensure => '0.3.0-333.pe.el6' }
  package { 'pe-augeas': ensure => '0.10.0-3.pe.el6' }
  package { 'pe-mcollective': ensure => '1.2.1-13.pe.el6' }
  package { 'pe-ruby-augeas': ensure => '0.4.1-1.pe.el6' }
  package { 'pe-ruby-ri': ensure => '1.8.7.370-1.pe.el6' }
  package { 'pe-puppet-enterprise-release': ensure => '2.6.1-1.pe.el6' }
  package { 'pe-ruby': ensure => '1.8.7.370-1.pe.el6' }
  package { 'pe-ruby-irb': ensure => '1.8.7.370-1.pe.el6' }
  package { 'pe-rubygems': ensure => '1.5.3-1.pe.el6' }
  package { 'pe-mcollective-common': ensure => '1.2.1-13.pe.el6' }
  package { 'pe-puppet': ensure => '2.7.19-3.pe.el6' }
  package { 'pe-augeas-libs': ensure => '0.10.0-3.pe.el6' }
  package { 'pe-rubygem-hiera-puppet': ensure => '0.3.0-1.pe.el6' }
  package { 'pe-rubygem-stomp-doc': ensure => '1.1.9-3.pe.el6' }
  package { 'pe-ruby-ldap': ensure => '0.9.8-5.pe.el6' }
}
