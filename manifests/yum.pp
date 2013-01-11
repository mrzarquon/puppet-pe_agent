class pe_agent::yum {
  include pe_agent::params

  $pe_repo = $pe_agent::params::pe_repo
  
  yumrepo { "puppetenterprise":
    baseurl  => "${pe_repo}/el-\$releasever-\$basearch",
    descr    => "Puppet Enterprises EL Packages",
    enabled  => 1,
    gpgcheck => 0,
  }
}
